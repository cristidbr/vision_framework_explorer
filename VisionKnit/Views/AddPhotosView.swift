//
//  AddPhotosView.swift
//  VisionKnit
//

import PhotosUI
import SwiftUI

struct AddPhotosView: View {
    @EnvironmentObject var properties: VisionPreviewProperties
    #if os(iOS)
    @State private var selection: [PhotosPickerItem] = []
    #endif
    
    @ViewBuilder func renderItem() -> some View
    {
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
                    
                    #if os(macOS)
                    Button( action: handlePanelOpen, label:
                        {
                            Color.clear
                                .frame(height: geometry.size.height)
                        })
                        .opacity(0)
                    #elseif os(iOS)
                    PhotosPicker(
                        selection: $selection.onChange(handleSelectedImages), matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Rectangle()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .foregroundColor(.clear)
                    }
                    #endif
                }
            }
            .opacity( 0.37 )
    }
    
    @ViewBuilder func renderButton() -> some View
    {
        #if os(iOS)
        PhotosPicker(
            selection: $selection.onChange(handleSelectedImages), matching: .images,
            photoLibrary: .shared()
        ) {
            Image( systemName: "plus" )
                .foregroundColor(.accentColor)
        }
        #endif
    }
    
    var body: some View {
        #if os(macOS)
        renderItem()
        #elseif os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            renderItem()
        } else {
            renderButton()
        }
        #endif
    }
    
    private func handlePanelOpen()
    {
        #if os(macOS)
        let panel = NSOpenPanel()
        
        panel.prompt = "Select File"
        panel.allowsMultipleSelection = true
        panel.canChooseDirectories = false
        panel.canCreateDirectories = true
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.image, .rawImage]
        panel.begin { result in
            if result == .OK
            {
                Task( priority: .background )
                {
                    if handleSelectedFiles(urls: panel.urls) {}
                }
            }
        }
        #endif
    }
    
    private func handleSelectedFiles(urls: [URL]) -> Bool
    {
        #if os(macOS)
        let itemsCount = urls.count
        for (i, url) in urls.enumerated()
        {
            if let nsimage = NSImage(contentsOf: url)
            {
                let cgImage = loadCGImage(nsimage)
                let upImage = ImageUserUpload(cgImage)
                let preselect = (i+1)==itemsCount

                DispatchQueue.main.async {
                    properties.userUploads.insert(upImage, at: 0)
                    if preselect {
                        properties.selectedSample = upImage.id
                    }
                }
            } else {
                return false
            }
        }
        #endif
    
        return true
    }
    
    #if os(iOS)
    private func handleSelectedImages(items: [PhotosPickerItem]) {
        let itemsCount = items.count
        for (i, item) in items.enumerated() {
            item.loadTransferable(type: Data.self) {
                result in

                switch result
                {
                case .success(let data):
                    if data != nil {
                        guard let imgdata = data else { return }
                        let cgImage = loadCGImage(imgdata)
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
    #endif 
}

#Preview {
    AddPhotosView()
}
