//
//  RecognizedPolygonView.swift
//  VisionKnit
//

import SwiftUI
import Vision
// TODO: it should be moved to a separate file
// TODO: Remove white space, ";
struct QuadrilateralPoly : Shape
{
    public let topLeft: CGPoint;
    public let bottomLeft: CGPoint;
    public let bottomRight: CGPoint;
    public let topRight: CGPoint;
    
    func path( in area: CGRect ) -> Path
    {
        let vw = Int( area.width );
        let vh = Int( area.height );
        
        var path = Path();
        
        path.move( to: VNImagePointForNormalizedPoint( topLeft, vw, vh ) );
        path.addLine( to: VNImagePointForNormalizedPoint( bottomLeft, vw, vh ) );
        path.addLine( to: VNImagePointForNormalizedPoint( bottomRight, vw, vh ) );
        path.addLine( to: VNImagePointForNormalizedPoint( topRight, vw, vh ) );
        path.addLine( to: VNImagePointForNormalizedPoint( topLeft, vw, vh ) );

        return path;
    }
}
// TODO: Remove white space, ";
struct RecognizedPolygonView: View
{
    public let topLeft: CGPoint;
    public let bottomLeft: CGPoint;
    public let bottomRight: CGPoint;
    public let topRight: CGPoint;
    
    var body: some View
    {
        QuadrilateralPoly( topLeft: topLeft, bottomLeft: bottomLeft, bottomRight: bottomRight, topRight: topRight )
                .stroke( Color.accentColor, lineWidth: 2 )
    }
}

struct RecognizedPolygonView_Previews: PreviewProvider
{
    static var previews: some View
    {
        RecognizedPolygonView( topLeft: CGPoint( x: 0.7, y: 0.2 ),
                               bottomLeft: CGPoint( x: 0.725, y: 0.3 ),
                               bottomRight: CGPoint( x: 0.825, y: 0.31 ),
                               topRight: CGPoint( x: 0.85, y: 0.19 )
        )
    }
}
