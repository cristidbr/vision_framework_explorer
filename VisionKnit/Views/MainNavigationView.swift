//
//  MainNavigationView.swift
//  VisionKnit
//

import SwiftUI

struct MainNavigationView: View {
    @EnvironmentObject var properties: VisionPreviewProperties

    @State private var splitViewConfiguration = NavigationSplitViewVisibility.all
    @State private var isDropTargeted: Bool = false
    @State private var tabSelection = 1

    var body: some View {
        #if os(macOS)
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
                                    let cgimage = loadCGImage(data)
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
                            DropTargetOverlayView()
                        }
                    }
            }
        #elseif os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                NavigationSplitView(columnVisibility: $splitViewConfiguration) {
                    SidebarView()
                        .navigationSplitViewColumnWidth(min: 200, ideal: 250, max: 400)
                } content: {
                    ReferencesView()
                        .navigationSplitViewColumnWidth(min: 200, ideal: 300, max: 400)
                } detail: {
                    ActionView()
                        .navigationSplitViewColumnWidth(min: 200, ideal: 800, max: 8000)
                }
            }
            else
            {
                NavigationSplitView(columnVisibility: $splitViewConfiguration) {
                    SidebarView()
                        .navigationTitle("Vision Explorer")
                }
                detail: 
                {
                    TabView(selection: $tabSelection) {
                        ActionView()
                            .tabItem {
                                Label("Preview", systemImage: "testtube.2")
                            }
                            .tag(1)
                        
                        ReferencesView()
                            .tabItem {
                                Label("Details", systemImage: "info.circle")
                            }
                            .tag(2)
                    }
                    .toolbar
                    {
                        if tabSelection == 1 && UIDevice.current.userInterfaceIdiom != .pad
                        {
                            ToolbarItem(placement: .navigationBarTrailing)
                            {
                                AddPhotosView()
                            }
                        }
                    }
                    .onAppear {
                        tabSelection = 1
                    }
                    .navigationBarTitle("", displayMode: .inline)
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
        #elseif os(tvOS)
            NavigationSplitView
            {
                SidebarView()
                    .navigationSplitViewColumnWidth(min: 200, ideal: 250, max: 400)
                    .navigationTitle("Vision Explorer")
            } detail:
            {
                GeometryReader
                {
                    geometry in
                    HStack
                    {
                        ActionView()
                            .navigationSplitViewColumnWidth(min: 200, ideal: 800, max: 8000)
                        ReferencesView()
                            .navigationSplitViewColumnWidth(min: 200, ideal: 300, max: 400)
                            .frame(maxWidth: geometry.size.width * 0.37)
                    }
                }
            }
        #endif
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}
