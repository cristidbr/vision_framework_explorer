//
//  FeaturePrintView.swift
//  VisionKnit
//

import SwiftUI
// TODO: it should be moved to a separate file
// TODO: Remove white space, ";
struct FeaturePrintGraphShape : Shape
{
    public let data: [ Double ];
    
    func path( in area: CGRect ) -> Path
    {
        let path = CGMutablePath();
        let elements = Double( data.count );
        
        path.move( to: CGPoint( x: 0, y: 0 ) );
        
        for column in 0..<data.count
        {
            var val = min( 1.0, data[ column ] );
            
            val = val * val;
            
            path.addLine( to: CGPoint( x: val, y: Double( column ) / elements ) );
            path.addLine( to: CGPoint( x: val, y: Double( column + 1 ) / elements ) );
        }
        
        path.addLine( to: CGPoint( x: 0, y: 1 ) )
        path.closeSubpath();
        
        var transform = CGAffineTransform( scaleX: area.width, y: area.height );
        
        return Path( path.copy( using: &transform ) ?? path );
    }
}

// TODO: Remove white space, ";
struct FeaturePrintView: View
{
    let data: [ Double ];
    
    init( _ data: [ Double ] )
    {
        self.data = data
    }
    
    var body: some View
    {
        FeaturePrintGraphShape( data: data )
            .fill( Color.accentColor )
    }
}

struct FeaturePrintView_Previews: PreviewProvider
{
    static var previews: some View
    {
        FeaturePrintView( [ 1.0, 0.2, 3.5 ] )
    }
}
