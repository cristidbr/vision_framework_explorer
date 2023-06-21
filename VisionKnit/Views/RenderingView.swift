//
//  RenderingView.swift
//  VisionKnit
//

import SwiftUI
import Vision
import StoreKit

// TODO: Remove white space, ";
struct RenderingView: View
{
    @Environment( \.requestReview ) var requestReview;
    
    @EnvironmentObject var properties: VisionPreviewProperties;
    
    public let viewMode: ResultsViewMode;
    
    @State private var results: [ VNObservation ]? = nil;
    
    var body: some View
    {
        let sample = getSelectedImageSampleByMethod( properties.selectedMethod, selected: properties.selectedSample );
        
        ResultsView( viewMode: viewMode )
        {
            MediaView( sample: sample )
        }
        results:
        {
            ResultRenderingView( results )
        }
        .onAppear( perform: handleVisionRequest )
        .onChange( of: sample, perform: { _ in handleVisionRequest() } )
    }
    
    func handleVisionRequest( )
    {
        let methodData = getSelectedMethod( properties.selectedMethod );
        let sampleData = getSelectedImageSampleByMethod( properties.selectedMethod, selected: properties.selectedSample );
        let cgImage = loadCGImage( sampleData.path );
        let visionRequest = makeVisionRequest( path: methodData.path );
        
        results = [];
        
        executeVisionRequest( cgImage: cgImage, request: visionRequest )
        {
            results = $0;
        }
        
        incrementInteractions()
            
        if( shouldShowReviewDialog() )
        {
            DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + 2.0 )
            {
                requestReview();
            }
        }
    }
}

struct RenderingView_Previews: PreviewProvider
{
    static var previews: some View
    {
        RenderingView( viewMode: .overlay )
            .environmentObject( VisionPreviewProperties() )
    }
}
