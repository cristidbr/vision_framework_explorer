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
                    let method_path = method?.path ?? ""
                    
                    if method_path != "core-ml-unsupported" {
                        #if os(macOS)
                        AddPhotosView()
                        #elseif os(iOS)
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            if method != nil {
                                AddPhotosView()
                            }
                        }
                        #endif
                        
                        ForEach(properties.userUploads) {
                            item in
                            
                            Button
                            {
                                properties.selectedSample = item.id
                            } label: {
                                GalleryThumbnailView(uploaded: item, selected: sample_id == item.id) {
                                    id in
                                    
                                    properties.userUploads = properties.userUploads.filter { $0.id != id }
                                    
                                    if properties.userUploads.count > 0 {
                                        properties.selectedSample = properties.userUploads[0].id
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                            .padding(.all, 0)
                        }
                    }
                    
                    ForEach(method?.samples ?? []) {
                        item in
                        
                        Button
                        {
                            properties.selectedSample = item.id
                        } label: {
                            GalleryThumbnailView(sample: item, selected: sample_id == item.id)
                        }
                        .buttonStyle(.plain)
                        .padding( .all, 0 )
                    }
                }
            }
            .padding(8)
            .frame(maxHeight: 120)
        }
        .preference(key: ResultsModePreferenceKey.self, value: method?.preview ?? .overlay)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
            .environmentObject(VisionPreviewProperties())
    }
}
