//
//  ActionView.swift
//  VisionKnit
//

import SwiftUI
import Vision

struct ActionView: View {
    @EnvironmentObject var properties: VisionPreviewProperties

    @State private var viewMode: ResultsViewMode = .overlay

    var body: some View {
        VStack(spacing: 0) {
            RenderingView(viewMode: viewMode)
            Divider()
            GalleryView()
        }
        .onPreferenceChange(ResultsModePreferenceKey.self) {
            viewMode = $0
        }
    }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView()
            .environmentObject(VisionPreviewProperties())
    }
}
