//
//  MainNavigationView.swift
//  VisionKnit
//

import SwiftUI

// TODO: Remove white space, ";" and add image name as Constant on separate file
struct MainNavigationView: View
{
    @EnvironmentObject var properties: VisionPreviewProperties;

    @State private var splitViewConfiguration = NavigationSplitViewVisibility.all;
    
    var body: some View
    {
        // TODO: Remove white space
        NavigationSplitView( columnVisibility: $splitViewConfiguration )
        {
            SidebarView()
                .navigationSplitViewColumnWidth( min: 150, ideal: 200, max: 400 )
        }
        content:
        {
            ReferencesView()
                .navigationSplitViewColumnWidth( min: 150, ideal: 200, max: 400 )
        }
        detail:
        {
            ActionView()
                .navigationSplitViewColumnWidth( min: 200, ideal: 800, max: 8000 )
        }
    }
}

struct MainNavigationView_Previews: PreviewProvider
{
    static var previews: some View
    {
        MainNavigationView()
    }
}
