//
//  SidebarView.swift
//  VisionKnit
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var properties: VisionPreviewProperties

    var body: some View {
        List(selection: $properties.selectedMethod) {
            Section {
                ForEach(VisionAPIDescription) {
                    api_method in
                    NavigationLink(
                        value: api_method.id,
                        label: {
                            Label("\( api_method.named! )", systemImage: "\( api_method.icon! )")
                        })
                }
            } header: {
                Text("Vision")
            }
        }
        .listStyle(.sidebar)
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .environmentObject(VisionPreviewProperties())
    }
}
