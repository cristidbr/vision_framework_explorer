//
//  SidebarView.swift
//  VisionKnit
//

import SwiftUI


// TODO: Remove white space, ";" and add image name as Constant on separate file
struct SidebarView: View
{
    @EnvironmentObject var properties: VisionPreviewProperties;
    
    var body: some View
    {
        List( selection: $properties.selectedMethod )
        {
            Section
            {
                // TODO: Remove white space
                ForEach( VisionAPIDescription )
                {
                    // TODO: Remove white space
                    api_method in
                        NavigationLink( value: api_method.id, label: {
                            Label( "\( api_method.named! )", systemImage: "\( api_method.icon! )" )
                        })
                }
            }
            header:
            {
                // TODO: Remove white space
                Text( "Vision" )
            }
        }
        // TODO: Remove white space
        .listStyle( .sidebar )
    }
}

struct SidebarView_Previews: PreviewProvider
{
    static var previews: some View
    {
        SidebarView()
            .environmentObject( VisionPreviewProperties() )
    }
}
