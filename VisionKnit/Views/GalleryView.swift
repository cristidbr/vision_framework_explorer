//
//  GalleryView.swift
//  VisionKnit
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var properties: VisionPreviewProperties

    var body: some View {
        let method = getSelectedMethod(properties.selectedMethod)
        let sample_id = getSelectedImageUUIDByMethod(
            properties.selectedMethod, uploads: properties.userUploads,
            selected: properties.selectedSample)
        let glayout: [GridItem] = Array(repeating: .init(.adaptive(minimum: 120)), count: 1)

        ScrollView(.horizontal, showsIndicators: true) {
            VStack {
                LazyHGrid(rows: glayout, alignment: .center, spacing: 4) {
                    if method.path != "core-ml-unsupported" {
                        AddPhotosView()

                        ForEach(properties.userUploads) {
                            item in

                            GalleryThumbnailView(uploaded: item, selected: sample_id == item.id) {
                                id in

                                properties.userUploads = properties.userUploads.filter { $0.id != id }

                                if properties.userUploads.count > 0 {
                                properties.selectedSample = properties.userUploads[0].id
                                }
                            }
                            .onTapGesture {
                                properties.selectedSample = item.id
                            }
                        }
                    }

                    ForEach(method.samples) {
                        item in

                        GalleryThumbnailView(sample: item, selected: sample_id == item.id)
                            .onTapGesture {
                                properties.selectedSample = item.id
                            }
                    }
                }
            }
            .padding(6)
            .frame(maxHeight: 120)
        }
        .preference(key: ResultsModePreferenceKey.self, value: method.preview)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
            .environmentObject(VisionPreviewProperties())
    }
}
