//
//  MainNavigationView.swift
//  VisionKnit
//

import SwiftUI

struct MainNavigationView: View {
    @EnvironmentObject var properties: VisionPreviewProperties

    @State private var splitViewConfiguration = NavigationSplitViewVisibility.all
    @State private var isDropTargeted: Bool = false

    var body: some View {
        NavigationSplitView(columnVisibility: $splitViewConfiguration) {
            SidebarView()
                .navigationSplitViewColumnWidth(min: 150, ideal: 200, max: 400)
        } content: {
            ReferencesView()
                .navigationSplitViewColumnWidth(min: 150, ideal: 200, max: 400)
        } detail: {
            ActionView()
                .navigationSplitViewColumnWidth(min: 200, ideal: 800, max: 8000)
                .onDrop(of: [.image], isTargeted: $isDropTargeted) {
                    providers in

                    let providerCount = providers.count

                    for (i, provider) in providers.enumerated() {
                        _ = provider.loadDataRepresentation(for: .image) {
                            data, error in

                            if error == nil, let data {
                                let nsimage = NSImage(data: data)
                                let cgimage = loadCGImage(nsimage!)
                                let upimage = ImageUserUpload(cgimage)
                                let preselect = (i+1)==providerCount

                                DispatchQueue.main.async {
                                    properties.userUploads.insert(upimage, at: 0)

                                    if preselect {
                                        properties.selectedSample = upimage.id
                                    }
                                }
                            }
                        }
                    }

                    return true
                }
                .overlay {
                    if isDropTargeted {
                        Color.black.opacity(0.2)
                            .overlay {
                                VStack(alignment: .center) {
                                    Spacer()
                                    Image(systemName: "tray.and.arrow.down")
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .colorInvert()

                                    Text("Drop Here")
                                        .font(.system(.title2))
                                        .colorInvert()

                                    Spacer()
                                }
                            }
                    }
                }
        }
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}
