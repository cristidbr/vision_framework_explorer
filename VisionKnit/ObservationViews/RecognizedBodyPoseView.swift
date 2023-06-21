//
//  RecognizedBodyPoseView.swift
//  VisionKnit
//

import SwiftUI
import Vision

// TODO: Remove white space, ";
struct RecognizedBodyPoseView: View
{
    let observation: VNHumanBodyPoseObservation;
    let areaSize: CGSize;
    
    var body: some View
    {
        let path = observation.toDrawableCGPath();
        var transform = CGAffineTransform( scaleX: areaSize.width, y: areaSize.height );
        
        Path( path.copy( using: &transform ) ?? path )
            .stroke( Color.accentColor, lineWidth: 2 )
    }
}

struct RecognizedBodyPoseView_Previews: PreviewProvider
{
    static var previews: some View
    {
        Text( "No preview" )
    }
}
