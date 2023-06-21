//
//  HorizonLineView.swift
//  VisionKnit
//

import SwiftUI
import Vision
// TODO: it should be moved to a separate file
// TODO: Remove white space, ";
struct HorizonLine : Shape
{
    public let transform: CGAffineTransform;
    public let imageSize: CGSize;
    
    func path( in area: CGRect ) -> Path
    {
        let vw = Int( area.width );
        let vh = Int( area.height );
        
        var path = Path();
        let begin = VNImagePointForNormalizedPoint( CGPoint( x: -0.5, y: 0.5 ), vw, vh );
        let end = VNImagePointForNormalizedPoint( CGPoint( x: 1.5, y: 0.5 ), vw, vh );
        
        let areaTransform = CGAffineTransform( a: transform.a, b: transform.b, c: transform.c, d: transform.d, tx: 0, ty: transform.ty / imageSize.height * Double( vh ) );
        
        path.move( to: begin.applying( areaTransform ) );
        path.addLine( to: end.applying( areaTransform ) );

        return path;
    }
}
// TODO: Remove white space, ";
struct HorizonLineView: View
{
    let transform: CGAffineTransform;
    let rotationAngle: CGFloat;
    let cgImage: CGImage;
    
    public init( _ transform: CGAffineTransform, rotationAngle: CGFloat, cgImage: CGImage )
    {
        self.transform = transform;
        self.rotationAngle = rotationAngle;
        self.cgImage = cgImage;
    }
    
    var body: some View
    {
        ZStack
        {
            Image( decorative: cgImage, scale: 1.0 )
                .antialiased( true )
                .resizable()
                .scaledToFit()
                .cornerRadius( 4 )
                
            HorizonLine( transform: transform, imageSize: CGSize( width: cgImage.width, height: cgImage.height ) )
                .stroke( Color.accentColor, lineWidth: 2 )
        }
        .rotationEffect( .radians( -rotationAngle ) )
    }
}

struct HorizonLineView_Previews: PreviewProvider
{
    
    static var previews: some View
    {
        HorizonLineView( .identity, rotationAngle: 0, cgImage: loadCGImage( "op-img-detect-horizon-1" ) )
    }
}
