//
//  SidebarView.swift
//  VisionKnit
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var properties: VisionPreviewProperties

    var body: some View {
        #if os(macOS)
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
        #elseif os(iOS)
        List(selection: $properties.selectedMethod)
        {
            ForEach(VisionAPIDescription) {
                api_method in
                NavigationLink(
                    value: api_method.id,
                    label: {
                        Label("\( api_method.named! )", systemImage: "\( api_method.icon! )")
                    })
            }
        }
        .listStyle(.sidebar)
        #elseif os(tvOS)
        List(selection: $properties.selectedMethod)
        {
            ForEach(VisionAPIDescription) {
                api_method in
                NavigationLink(
                    value: api_method.id,
                    label: {
                        Label("\( api_method.named! )", systemImage: "\( api_method.icon! )").padding(.all, 8)
                    })
            }
        }
        #endif
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .environmentObject(VisionPreviewProperties())
    }
}
