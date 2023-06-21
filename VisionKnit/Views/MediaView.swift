//
//  MediaView.swift
//  VisionKnit
//

import SwiftUI
// TODO: it should be moved to a separate file
// TODO: Remove white space, ";
struct MediaSizingPreferenceKey: PreferenceKey
{
    typealias Value = CGSize;
    static var defaultValue: Value = .zero;
    
    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value = nextValue()
    }
}

// TODO: Remove white space, ";" 
struct MediaView: View
{
    @Environment( \.colorScheme ) var colorScheme
    
    let sample: ImageSampleReference;
    
    var body: some View
    {
        let samplePath = ( sample.darkVersion && colorScheme == .dark ) ?
            "\( sample.path )-dark" :
            sample.path;
        
        Image( samplePath )
            .antialiased( true )
            .resizable()
            .scaledToFit()
            .cornerRadius( 4 )
            .aspectRatio( contentMode: .fit )
            .background
            {
                GeometryReader
                {
                    geometry in
                        Rectangle()
                            .fill( Color.clear )
                            .preference(
                                key: MediaSizingPreferenceKey.self,
                                value: geometry.size
                            )
                }
            }
    }
}

struct MediaView_Previews: PreviewProvider
{
    static var previews: some View
    {
        MediaView( sample: VisionAPIDescription[ 0 ].samples[ 0 ] )
    }
}
