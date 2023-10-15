//
//  GalleryThumbnailView.swift
//  VisionKnit
//

import SwiftUI

struct GalleryThumbnailView: View {
    @Environment(\.colorScheme) var colorScheme

    public let sample: ImageSampleReference?
    public let uploaded: ImageUserUpload?
    public let selected: Bool
    public let onRemove: ((UUID) -> Void)?

    init(sample: ImageSampleReference, selected: Bool) {
        self.sample = sample
        self.uploaded = nil
        self.selected = selected
        self.onRemove = nil
    }

    init(uploaded: ImageUserUpload, selected: Bool, onRemove: ((UUID) -> Void)?) {
        self.sample = nil
        self.uploaded = uploaded
        self.selected = selected
        self.onRemove = onRemove
    }

    var body: some View {
        if sample != nil {
            let samplePath =
                (sample!.darkVersion && colorScheme == .dark) ? "\( sample!.path )-dark" : sample!.path

            Image(samplePath)
                .interpolation(.high)
                .resizable()
                .scaledToFit()
                .cornerRadius(4)
                .padding(2)
                .background(selected ? Color.accentColor : Color.clear)
                .cornerRadius(6)
        } else {
            Image(
                nsImage: NSImage(
                cgImage: uploaded!.image,
                size: NSSize(width: uploaded!.image.width, height: uploaded!.image.height))
            )
            .interpolation(.high)
            .resizable()
            .scaledToFit()
            .cornerRadius(4)
            .padding(2)
            .background(selected ? Color.accentColor : Color.clear)
            .cornerRadius(6)
            .overlay {
                HStack(alignment: .top) {
                    Spacer()

                    VStack(alignment: .trailing) {
                        Button {
                            if onRemove != nil {
                                onRemove!(uploaded!.id)
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color.white)
                                .frame(width: 16, height: 16)
                                .shadow(color: Color.black, radius: 2, x: 0, y: 0)
                                .padding(.all, 6)
                                .border(.clear, width: 1)
                                .opacity(0.37)
                        }
                        .buttonStyle(.plain)

                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    EmptyView()
}
