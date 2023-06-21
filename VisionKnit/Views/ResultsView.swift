//
//  ResultsView.swift
//  VisionKnit
//

import SwiftUI
// TODO: Remove white space, ";" and add image name as Constant on separate file
struct ResultsView<Media, Results>: View where Media: View, Results: View
{
    public let viewMode: ResultsViewMode;
    
    public let media: Media;
    public let results: Results;
    
    @State private var mediaSize: CGSize = .zero;
    
    public init( viewMode: ResultsViewMode, @ViewBuilder media: () -> Media, @ViewBuilder results: () -> Results )
    {
        self.viewMode = viewMode;
        
        self.media = media();
        self.results = results();
    }
    
    var body: some View
    {
        VStack
        {
            switch viewMode
            {
                case .overlay:
                    self.makeOverlay()
                case .trailing:
                    self.makeTrailing()
                case .bottom:
                    self.makeBottom()
                case .split:
                    self.makeSplit()
            }
        }
    }
    
    @ViewBuilder private func makeMedia( ) -> some View
    {
        media
            .onPreferenceChange( MediaSizingPreferenceKey.self )
            {
                mediaSize = $0
            }
    }
    
    @ViewBuilder private func makeResults( ) -> some View
    {
        if( viewMode == .trailing )
        {
            results
                .frame( maxWidth: 180 )
        }
        else if( viewMode == .bottom )
        {
            results
                .frame( maxHeight: 180 )
        }
        else
        {
            Color.clear
                .overlay
                {
                    results
                        .background
                        {
                            RoundedRectangle( cornerRadius: 4 )
                                .stroke( .gray.opacity( 0.5 ), lineWidth: 1 )
                        }
                        .frame( width: mediaSize.width, height: mediaSize.height )
                        .clipped()
                }
        }
    }
    
    @ViewBuilder private func makeOverlay( ) -> some View
    {
        makeMedia( )
            .overlay
            {
                makeResults( )
            }
            .clipped()
            .padding( .all, 8 )
            .frame( maxHeight: .greatestFiniteMagnitude )
    }
    
    @ViewBuilder private func makeSplit( ) -> some View
    {
        GeometryReader
        {
            geometry in
                HStack( spacing: 0 )
                {
                    makeMedia( )
                        .padding( .all, 8 )
                        .frame( maxWidth: geometry.size.width / 2 )
    
                    Divider()
                    
                    makeResults( )
                        .frame( maxWidth: geometry.size.width / 2 )
                }
        }
    }
    
    @ViewBuilder private func makeTrailing( ) -> some View
    {
        HStack( spacing: 0 )
        {
            makeMedia( )
                .padding( .all, 8 )
                .frame( maxWidth: .greatestFiniteMagnitude )
            Divider()
            makeResults( )
        }
    }
    
    @ViewBuilder private func makeBottom( ) -> some View
    {
        VStack( spacing: 0 )
        {
            makeMedia( )
                .padding( .all, 8 )
                .frame( maxWidth: .greatestFiniteMagnitude )
            Divider()
            makeResults( )
        }
    }
}

struct ResultsView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ResultsView( viewMode: .overlay )
        {
            EmptyView()
        }
        results:
        {
            EmptyView()
        }
    }
}
