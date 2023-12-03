//
//  ResultsView.swift
//  VisionKnit
//

import SwiftUI

struct ResultsView<Media, Results>: View where Media: View, Results: View {
    public let viewMode: ResultsViewMode

    public let media: Media
    public let results: Results

    @State private var mediaSize: CGSize = .zero
    
    @GestureState private var sscale: CGFloat = 1.0
    @GestureState private var oscale: CGFloat = 1.0

    public init(
        viewMode: ResultsViewMode, @ViewBuilder media: () -> Media, @ViewBuilder results: () -> Results
    ) {
        self.viewMode = viewMode

        self.media = media()
        self.results = results()
    }

    var body: some View {
        VStack {
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
        .clipped()
    }

    @ViewBuilder private func makeMedia() -> some View {
        media
            .onPreferenceChange(MediaSizingPreferenceKey.self) {
                mediaSize = $0
            }
    }
    
    private func getTrailingViewSize() -> CGFloat
    {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom != .pad
        {
            return 150
        }
        #endif
        
        return 180
    }

    @ViewBuilder private func makeResults() -> some View {
        if viewMode == .trailing {
            results
                .frame(maxWidth: getTrailingViewSize())
        } else if viewMode == .bottom {
            results
                .frame(maxHeight: 180)
        } else {
            Color.clear
                .overlay {
                    results
                        .background {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                        }
                        .frame(width: mediaSize.width, height: mediaSize.height)
                        .clipped()
                        .scaleEffect(sscale, anchor: (viewMode == .split) ? .trailing : .center)
                }
        }
    }
    
    @ViewBuilder private func makeOverlayBase() -> some View
    {
        makeMedia()
            .overlay {
                makeResults()
            }
            .clipped()
            .padding(.all, 8)
            .frame(maxHeight: .greatestFiniteMagnitude)
            .scaleEffect(oscale, anchor: .center)
    }
    
    @ViewBuilder private func makeOverlay() -> some View {
        #if os(tvOS)
        makeOverlayBase()
        #else
        makeOverlayBase()
            .gesture(
                MagnificationGesture()
                    .updating($oscale) {
                        (newValue, scale, _) in
                        scale = min( max( newValue, 1.0 ), 3.0 )
                    }
            )
        #endif
    }

    @ViewBuilder private func makeSplit() -> some View {
        GeometryReader {
            geometry in

            HStack(spacing: 0) {
                makeMedia()
                    .padding(.all, 8)
                    .frame(maxWidth: geometry.size.width / 2)

                Divider()
                
                #if os(tvOS)
                makeResults()
                    .frame(maxWidth: geometry.size.width / 2)
                #else
                makeResults()
                    .frame(maxWidth: geometry.size.width / 2)
                    .gesture(
                        MagnificationGesture().updating($sscale) {
                            (newValue, scale, _) in
                            scale = min( max( newValue, 1.0 ), 3.0 )
                        }
                    )
                #endif
            }
        }
    }

    @ViewBuilder private func makeTrailing() -> some View {
        HStack(spacing: 0) {
            makeMedia()
                .padding(.all, 8)
                .frame(maxWidth: .greatestFiniteMagnitude)
            Divider()
            makeResults()
        }
    }

    @ViewBuilder private func makeBottom() -> some View {
        VStack(spacing: 0) {
            makeMedia()
                .padding(.all, 8)
                .frame(maxWidth: .greatestFiniteMagnitude)
            Divider()
            makeResults()
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(viewMode: .overlay) {
            EmptyView()
        } results: {
            EmptyView()
        }
    }
}
