//
//  ActionView.swift
//  VisionKnit
//

import SwiftUI
import Vision

// TODO: it should be moved to a separate file
// TODO: Remove white space, ";
struct ResultsModePreferenceKey: PreferenceKey
{
    typealias Value = ResultsViewMode;
    static var defaultValue: Value = .overlay;
    
    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value = nextValue()
    }
}
// TODO: Remove white space, ";"
struct ActionView: View
{
    @EnvironmentObject var properties: VisionPreviewProperties;
    
    @State private var viewMode: ResultsViewMode = .overlay;
    
    var body: some View
    {
        VStack( spacing: 0 )
        {
            RenderingView( viewMode: viewMode )
            Divider()
            GalleryView( )
        }
        .onPreferenceChange( ResultsModePreferenceKey.self )
        {
            viewMode = $0;
        }
    }
}

struct ActionView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ActionView()
            .environmentObject( VisionPreviewProperties() )
    }
}
