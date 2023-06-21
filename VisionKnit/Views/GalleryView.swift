//
//  GalleryView.swift
//  VisionKnit
//

import SwiftUI
// TODO: it should be moved to a separate file
// TODO: Remove white space, ";
struct GalleryThumbnailView: View
{
    @Environment( \.colorScheme ) var colorScheme
    
    public let sample: ImageSampleReference;
    public let selected: Bool;
    
    var body: some View
    {
        let samplePath = ( sample.darkVersion && colorScheme == .dark ) ?
            "\( sample.path )-dark" :
            sample.path;
        
        Image( samplePath )
            .interpolation( .high )
            .resizable()
            .scaledToFit()
            .cornerRadius( 4 )
            .padding( 2 )
            .background( selected ? Color.accentColor : Color.clear )
            .cornerRadius( 6 )
    }
}

// TODO: Remove white space, ";
struct GalleryView: View
{
    @EnvironmentObject var properties: VisionPreviewProperties;
    
    var body: some View
    {
        let method = getSelectedMethod( properties.selectedMethod );
        let sample = getSelectedImageSampleByMethod( method.id, selected: properties.selectedSample );
        let glayout: [ GridItem ] = Array( repeating: .init( .adaptive( minimum: 120 ) ), count: 1 );
        
        ScrollView( .horizontal, showsIndicators: true )
        {
            VStack
            {
                LazyHGrid( rows: glayout, alignment: .center, spacing: 4 )
                {
                    ForEach( method.samples )
                    {
                        item in
                        
                        GalleryThumbnailView( sample: item, selected: sample.id == item.id )
                            .onTapGesture
                            {
                                properties.selectedSample = item.id;
                            }
                    }
                }
            }
            .padding( 6 )
            .frame( maxHeight: 120 )
        }
        .preference( key: ResultsModePreferenceKey.self, value: method.preview )
    }
}

struct GalleryView_Previews: PreviewProvider
{
    static var previews: some View
    {
        GalleryView()
            .environmentObject( VisionPreviewProperties() )
    }
}
