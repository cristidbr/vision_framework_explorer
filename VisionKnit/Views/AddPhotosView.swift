//
//  AddPhotosView.swift
//  VisionKnit
//

import PhotosUI
import SwiftUI

struct AddPhotosView: View {
    @EnvironmentObject var properties: VisionPreviewProperties

    @State private var selection: [PhotosPickerItem] = []

    var body: some View {

        Rectangle()
            .fill(.clear)
            .aspectRatio(1.0, contentMode: .fit)
            .overlay {
                Rectangle()
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8, 3]))
                    .cornerRadius(6)
                    .padding(2)
            }
            .overlay {
                VStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "tray.and.arrow.down")
                        .resizable()
                        .frame(width: 24, height: 24)

                    Text("Add Photos")
                        .font(.system(.footnote))

                    Spacer()
                }
            }
            .overlay {
                GeometryReader {
                    geometry in

                    PhotosPicker(
                        selection: $selection.onChange(handleSelectedImages), matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Rectangle()
                        .frame(height: geometry.size.height)
                    }
                    .frame(width: geometry.size.width)
                    .opacity(0)
                }
            }
            .opacity(0.37)
    }

    private func handleSelectedImages(items: [PhotosPickerItem]) {
        let itemsCount = items.count
        for (i, item) in items.enumerated() {
            item.loadTransferable(type: Data.self) {
                result in

                switch result
                {
                case .success(let data):
                    if data != nil {
                        guard let nsImage = NSImage(data: data!) else { return }
                        let cgImage = loadCGImage(nsImage)
                        let upImage = ImageUserUpload(cgImage)
                        let preselect = (i+1)==itemsCount

                        DispatchQueue.main.async {
                            properties.userUploads.insert(upImage, at: 0)
                            if preselect {
                                properties.selectedSample = upImage.id
                            }
                        }
                    }
                case .failure:
                    break
                }
            }
        }

        DispatchQueue.main.async {
            selection = []
        }
    }
}

#Preview {
    AddPhotosView()
}
