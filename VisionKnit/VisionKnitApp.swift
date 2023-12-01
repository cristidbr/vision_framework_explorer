//
//  VisionKnitApp.swift
//  VisionKnit
//

import SwiftUI

@main
struct VisionKnitApp: App {
    @StateObject var properties = VisionPreviewProperties()

    var body: some Scene {
        WindowGroup {
            MainNavigationView()
                .environmentObject(properties)
                .onAppear {
                    #if DEBUG
                        resetUserStorageKeys()
                    #endif
                }
        }
    }
}

