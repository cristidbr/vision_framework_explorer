//
//  MediaView.swift
//  VisionKnit
//

import SwiftUI

struct MediaView: View {
    @EnvironmentObject var properties: VisionPreviewProperties

    @Environment(\.colorScheme) var colorScheme

    private func renderSample() -> Image {
        let sample = getSelectedImageSampleByMethod(
            properties.selectedMethod, selected: properties.selectedSample)
        
        if sample == nil {
            return Image(systemName: "camera.metering.unknown")
        }
        
        let samplePath =
            (sample!.darkVersion && colorScheme == .dark) ? "\( sample!.path )-dark" : sample!.path
        
        return Image(samplePath)
    }

    private func renderUpload() -> Image {
        let sample = getSelectedImageUserUploaded(
            uploads: properties.userUploads, selected: properties.selectedSample!)

        if sample == nil {
            return Image(systemName: "camera.metering.unknown")
        }
        
        #if os(macOS)
        let imsize = NSSize(width: sample!.image.width, height: sample!.image.height)
        let nsimage = NSImage(cgImage: sample!.image, size: imsize)

        return Image(nsImage: nsimage)
        #elseif os(iOS) || os(tvOS)
        return Image(uiImage: UIImage(cgImage: sample!.image))
        #endif
    }

    var body: some View {
        let data =
            isUserUploadedImage(uploads: properties.userUploads, selected: properties.selectedSample)
                ? renderUpload() : renderSample()

        data
            .antialiased(true)
            .resizable()
            .scaledToFit()
            .cornerRadius(4)
            .aspectRatio(contentMode: .fit)
            .background {
                GeometryReader {
                geometry in
                Rectangle()
                    .fill(Color.clear)
                    .preference(
                        key: MediaSizingPreferenceKey.self,
                        value: geometry.size
                    )
                }
            }
    }
}

struct MediaView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
