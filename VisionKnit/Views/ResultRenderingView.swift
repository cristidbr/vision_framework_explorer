//
//  ResultRenderingView.swift
//  VisionKnit
//

import SwiftUI
import Vision

// TODO: Remove white space, ";" and add image name as Constant on separate file
struct ResultRenderingView: View
{
    @EnvironmentObject var properties: VisionPreviewProperties;
    
    let observations: [ VNObservation ];
    private let failedRun: Bool;
    
    init( _ observations: [ VNObservation ]? )
    {
        self.observations = observations ?? [];
        self.failedRun = ( observations == nil );
    }
    
    var body: some View
    {
        GeometryReader
        {
            geometry in
            renderResults( geometry )
        }
    }
    
    @ViewBuilder private func renderFailMessage( ) -> some View
    {
        VStack( alignment: .center )
        {
            Spacer()
            HStack( alignment: .center )
            {
                Spacer()
                Text( "Failed to run" )
                    .opacity( 0.64 )
                Spacer()
            }
            Spacer()
        }
    }
    
    @ViewBuilder private func renderResults( _ geometry: GeometryProxy ) -> some View
    {
        let data = getSelectedMethod( properties.selectedMethod );
        let sample = getSelectedImageSampleByMethod( properties.selectedMethod, selected: properties.selectedSample );
        
        if( failedRun && data.path != "core-ml-unsupported" )
        {
            renderFailMessage();
        }
        else
        {
            switch observations
            {
            case is [ VNClassificationObservation ]:
                displayClassifications( observations as! [ VNClassificationObservation ] );
            case is [ VNBarcodeObservation ]:
                displayBarcodes( observations as! [ VNBarcodeObservation ], areaSize: geometry.size );
            case is [ VNSaliencyImageObservation ]:
                displaySaliency( observations as! [ VNSaliencyImageObservation ], areaSize: geometry.size, boxes: data.path == "objectness-saliency" );
            case is [ VNPixelBufferObservation ]:
                displaySegmentation( observations as! [ VNPixelBufferObservation ] );
            case is [ VNRecognizedTextObservation ]:
                displayText( observations as! [ VNRecognizedTextObservation ], areaSize: geometry.size );
            case is [ VNTextObservation ]:
                displayTextRectangles( observations as! [ VNTextObservation ], cgImage: loadCGImage( sample.path ) );
            case is [ VNFaceObservation ]:
                displayFaceObservations( observations as! [ VNFaceObservation ], areaSize: geometry.size, landmarks: data.path == "face-landmarks" );
            case is [ VNRectangleObservation ]:
                displayDocumentSegmentation( observations as! [ VNRectangleObservation ] );
            case is [ VNFeaturePrintObservation ]:
                displayFeaturePrint( observations as! [ VNFeaturePrintObservation ] );
            case is [ VNHorizonObservation ]:
                displayHorizon( observations as! [ VNHorizonObservation ], cgImage: loadCGImage( sample.path ) );
            case is [ VNHumanObservation ]:
                displayHumanRectangles( observations as! [ VNHumanObservation ], areaSize: geometry.size );
            case is [ VNContoursObservation ]:
                displayContours( observations as! [ VNContoursObservation ], areaSize: geometry.size );
            case is [ VNHumanBodyPoseObservation ]:
                displayHumanBodyPose( observations as! [ VNHumanBodyPoseObservation ], areaSize: geometry.size );
            case is [ VNHumanHandPoseObservation ]:
                displayHumanHandPose( observations as! [ VNHumanHandPoseObservation ], areaSize: geometry.size );
            case is [ VNRecognizedObjectObservation ]:
                displayLabeledObjects( observations as! [ VNRecognizedObjectObservation ], areaSize: geometry.size );
            default:
                if( data.path == "core-ml-unsupported" )
                {
                    displayCoreMLOutputs( observations );
                }
                else
                {
                    Text( "Unknown" )
                }
            }
        }
    }
    
    @ViewBuilder private func displayClassifications( _ array: [ VNClassificationObservation ] ) -> some View
    {
        let top100 = ( array.count > 100 ) ? array[ 0..<100 ] : array[ ... ];
        
        ScrollView( .vertical )
        {
            VStack( spacing: 0 )
            {
                ForEach( top100, id: \.uuid )
                {
                    item in
                        ConfidenceLabelView( item.identifier, confidence: Double( item.confidence ) )
                            .frame( height: 20 )
                }
            }
        }
    }
    
    @ViewBuilder private func displayBarcodes( _ array: [ VNBarcodeObservation ], areaSize: CGSize ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
                RecognizedRectangleView(
                    barcodeSymbologyToString( observation.symbology ),
                    boundingBox: observationBoundingBoxToArea( observation.boundingBox, areaSize: areaSize )
                );
        }
    }
    
    @ViewBuilder private func displaySegmentation( _ array: [ VNPixelBufferObservation ] ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
                RecognizedMaskView( pixelBuffer: observation.pixelBuffer )
        }
    }
    
    @ViewBuilder private func displayText( _ array: [ VNRecognizedTextObservation ], areaSize: CGSize ) -> some View
    {
        ZStack
        {
            ForEach( array, id: \.uuid )
            {
                observation in
                let label = observation.topCandidates( 1 ).first?.string ?? "";
                let bbox = observationBoundingBoxToArea( observation.boundingBox, areaSize: areaSize )
                let bboxSize = observationMeasureCornerPointsBoxRotatedSize( topLeft: observationPointToImagePoint( observation.topLeft, size: areaSize ),
                                                                                    bottomLeft: observationPointToImagePoint( observation.bottomLeft, size: areaSize ),
                                                                                    bottomRight: observationPointToImagePoint( observation.bottomRight, size: areaSize ),
                                                                                    topRight: observationPointToImagePoint( observation.topRight, size: areaSize ) )
                
                RecognizedTextView( label,
                                    boundingBox: CGRectInset( bbox, ( bbox.width - bboxSize.width ) / 2, ( bbox.height - bboxSize.height ) / 2 ),
                                    rotation: angleBetweenPoints(
                                        observationPointToImagePoint( observation.bottomRight, size: areaSize ),
                                        observationPointToImagePoint( observation.bottomLeft, size: areaSize )
                                    )
                )
            }
        }
    }
    
    @ViewBuilder private func displayDocumentSegmentation( _ array: [ VNRectangleObservation ] ) -> some View
    {
        ZStack
        {
            displayDocumentMask( array as [ VNDetectedObjectObservation ] );
            displayDocumentPoly( array );
        }
    }
    
    @ViewBuilder private func displayDocumentPoly( _ array: [ VNRectangleObservation ] ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
            
            RecognizedPolygonView( topLeft: observationPointInvertY( observation.topLeft ), bottomLeft: observationPointInvertY( observation.bottomLeft ), bottomRight: observationPointInvertY( observation.bottomRight ), topRight: observationPointInvertY( observation.topRight ) )
        }
    }
    
    @ViewBuilder private func displayDocumentMask( _ array: [ VNDetectedObjectObservation ] ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
            
            let mask = observation.globalSegmentationMask?.pixelBuffer;
            
            if( mask != nil )
            {
                RecognizedMaskView( pixelBuffer: mask! );
            }
        }
    }
    
    @ViewBuilder private func displayFaceObservations( _ array: [ VNFaceObservation ], areaSize: CGSize, landmarks: Bool ) -> some View
    {
        if( landmarks )
        {
            displayFaceLandmarks( array, areaSize: areaSize );
        }
        else
        {
            displayFaceRectangles( array, areaSize: areaSize );
        }
    }
    
    @ViewBuilder private func displayFaceRectangles( _ array: [ VNFaceObservation ], areaSize: CGSize ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
            
            let captureQuality = observation.faceCaptureQuality ?? -1.0;
            let label = ( captureQuality > 0 ) ? "\( Int(( captureQuality ) * 100 ) )%" : "";
            
            RecognizedRectangleView( label, boundingBox: observationBoundingBoxToArea( observation.boundingBox, areaSize: areaSize ) );
        }
    }
    
    @ViewBuilder private func displayFaceLandmarks( _ array: [ VNFaceObservation ], areaSize: CGSize ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
            
            ZStack
            {
                let path = observation.toDrawableCGPath();
                var transform = CGAffineTransform( scaleX: areaSize.width, y: areaSize.height );
                
                Path( path.copy( using: &transform ) ?? path )
                    .stroke( Color.accentColor, lineWidth: 1 )
                
                RecognizedFaceLandmarksView( observation.toCGPointsInArea( areaSize: areaSize ) );
            }
        }
    }
    
    @ViewBuilder private func displayTextRectangles( _ array: [ VNTextObservation ], cgImage: CGImage ) -> some View
    {
        ScrollView( showsIndicators: true )
        {
            VStack( spacing: 0 )
            {
                VStack( spacing: 8 )
                {
                    ForEach( array, id: \.uuid )
                    {
                        observation in
                        
                        let imageSize = CGSize( width: cgImage.width, height: cgImage.height );
                        let bbox = observationBoundingBoxToArea( observation.boundingBox, areaSize: imageSize );
                        
                        let cboxes = observation.characterBoxes ?? [];
                        let cbboxes = cboxes.map { observationBoundingBoxToArea( $0.boundingBox, areaSize: imageSize ) };
                        
                        RecognizedTextCharactersView( "", uuid: observation.uuid, cgImage: cgImage, boundingBox: bbox, characterBoxes: cbboxes );
                    }
                }
                .padding( .all, 8 )
                
                Spacer()
            }
        }
        .frame( maxWidth: .infinity )
    }
    
    
    
    @ViewBuilder private func displayHorizon( _ array: [ VNHorizonObservation ], cgImage: CGImage ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
            HorizonLineView( observation.transform, rotationAngle: observation.angle, cgImage: cgImage );
        }
    }
    
    @ViewBuilder private func displayHumanRectangles( _ array: [ VNHumanObservation ], areaSize: CGSize ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
            RecognizedRectangleView(
                observation.upperBodyOnly ? "UpperBody" : "FullBody",
                boundingBox: observationBoundingBoxToArea( observation.boundingBox, areaSize: areaSize )
            );
        }
    }
    
    @ViewBuilder private func displayContours( _ array: [ VNContoursObservation ], areaSize: CGSize ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
            ContoursView( observation: observation, areaSize: areaSize )
        }
    }
    
    @ViewBuilder private func displayHumanBodyPose( _ array: [ VNHumanBodyPoseObservation ], areaSize: CGSize ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
            
            ZStack
            {
                let points = observation.toCGPointsInArea( areaSize: areaSize );
                
                RecognizedBodyPoseView( observation: observation, areaSize: areaSize );
                
                ForEach( 0..<points.count, id: \.self )
                {
                    idx in
                    
                    let pt = points[ idx ];
                    Circle()
                        .fill( Color.accentColor )
                        .frame( width: 8, height: 8 )
                        .position( x: pt.x, y: pt.y )
                }
            }
        }
    }
    
    @ViewBuilder private func displayHumanHandPose( _ array: [ VNHumanHandPoseObservation ], areaSize: CGSize ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
            
            ZStack
            {
                let points = observation.toCGPointsInArea( areaSize: areaSize );
                
                RecognizedHandPoseView( observation: observation, areaSize: areaSize );
                
                ForEach( 0..<points.count, id: \.self )
                {
                    idx in
                    
                    let pt = points[ idx ];
                    Circle()
                        .fill( Color.accentColor )
                        .frame( width: 8, height: 8 )
                        .position( x: pt.x, y: pt.y )
                }
            }
        }
    }
    
    @ViewBuilder private func displayLabeledObjects( _ array: [ VNRecognizedObjectObservation ], areaSize: CGSize ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
            
            let label = observation.labels.first?.identifier.capitalized ?? "";
            
            RecognizedRectangleView(
                "\( label ) \( Int( observation.confidence * 100 ) )%",
                boundingBox: observationBoundingBoxToArea( observation.boundingBox, areaSize: areaSize )
            );
        }
    }
    
    @ViewBuilder private func displaySaliency( _ array: [ VNSaliencyImageObservation ], areaSize: CGSize, boxes: Bool ) -> some View
    {
        ZStack
        {
            ForEach( array, id: \.uuid )
            {
                observation in
                RecognizedMaskView( pixelBuffer: observation.pixelBuffer )
            }
            
            if( boxes )
            {
                ForEach( array, id: \.uuid )
                {
                    observation in
                    
                    let objects = observation.salientObjects ?? [];
                    
                    ForEach( objects, id: \.uuid )
                    {
                        object in
                        
                        RecognizedRectangleView(
                            "\( Int( object.confidence * 100 ) )%",
                            boundingBox: observationBoundingBoxToArea( object.boundingBox, areaSize: areaSize )
                        );
                    }
                }
            }
        }
    }
    
    @ViewBuilder private func displayFeaturePrint( _ array: [ VNFeaturePrintObservation ] ) -> some View
    {
        ForEach( array, id: \.uuid )
        {
            observation in
            
            let numeric = observation.data.withUnsafeBytes { Array( $0.bindMemory( to: Float.self ) ) };
            let numericd = numeric.compactMap { Double( $0 ) };
            
            FeaturePrintView( numericd );
        }
    }
    
    @ViewBuilder private func displayCoreMLOutputs( _ array: [ VNObservation ] ) -> some View
    {
        EmptyView();
    }
}

struct ResultRenderingView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ResultRenderingView( [] )
            .environmentObject( VisionPreviewProperties() )
    }
}
