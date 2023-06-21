//
//  ContentView.swift
//  VisionKnit
//

import SwiftUI

struct ContentView: View
{
    // TODO: Move this code into VisionKnitApp And delete this file
    @StateObject var properties = VisionPreviewProperties();
    
    var body: some View
    {
        MainNavigationView()
            .environmentObject( properties )
            .onAppear
            {
                #if DEBUG
                resetUserStorageKeys()
                #endif
            }
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}
