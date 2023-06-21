//
//  ReferencesView.swift
//  VisionKnit
//

import SwiftUI



struct CodeReferenceListView : View
{
    // TODO: Remove white space, ";" and add image name as Constant on separate file
    let references: [ CodeReference ];
    
    var body: some View
    {
        let references_sorted = references.sorted();
        
        List
        {
            ForEach( 0..<references_sorted.count, id: \.self )
            {
                // TODO: Remove white space, ";"
                idx in
                    let reference = references_sorted[ idx ];
                
                    Button
                    {
                        openURLInBrowser( reference.url );
                    }
                    label:
                    {
                        HStack
                        {
                            if reference.ranking != nil
                            {// TODO: Remove white space
                                Image( systemName: "star.fill" )
                                    .resizable()
                                    .aspectRatio( contentMode: .fit )
                                    .scaledToFit()
                                    .frame( height: 12 )
                                // TODO: Remove white space
                                Text( String( reference.ranking! ) )
                                    .font( .footnote )
                            }
                            // TODO: Remove white space
                            Text( reference.url.replacingOccurrences(of: "https://", with: "" ) )
                            // TODO: Remove white space
                                .lineLimit( 1 )
                            // TODO: Remove white space
                                .truncationMode( .tail )
                            
                        }
                    }
                // TODO: Remove white space
                    .buttonStyle( .plain )
                // TODO: Remove white space
                    .listRowBackground( RoundedRectangle( cornerRadius: 6 ).fill( ( idx % 2 == 0 ) ? Color.gray.opacity( 0.2 ) : Color.clear ) )
            }
        }
        // TODO: Remove white space
        .listStyle( .plain )
        // TODO: Remove white space
        .scrollContentBackground( .hidden )
        // TODO: Remove white space
        .padding( [ .top, .bottom ], 0 )
    }
}
//TODO: make it in the separate file
struct ReferencesView<Controls> : View where Controls: View
{
    @EnvironmentObject var properties: VisionPreviewProperties;
    
    let controls: Controls;
    
    init( @ViewBuilder controls: () -> Controls )
    {
        self.controls = controls();
    }
    
    init() where Controls == EmptyView
    {
        self.controls = EmptyView();
    }
    
    var body: some View
    {
        let data = getSelectedMethod( properties.selectedMethod );
        let sample = getSelectedImageSampleByMethod( properties.selectedMethod, selected: properties.selectedSample );
        
        VStack( alignment: .leading )
        {
            let title_name = ( data.named == nil ) ? data.title : data.named!;
            let doc_url = "https://developer.apple.com/documentation/vision/\( data.title.lowercased() )"
            
            VStack( alignment: .leading )
            {
                Text( title_name )
                    .font( .title )
                    .padding( .bottom, 8 )
                
                Text( data.description )
                    .font( .body )
                
                Button
                {
                    openURLInBrowser( doc_url );
                }
                label:
                {
                    Label( data.title, systemImage: "arrow.up.right.square" )
                }
                .tint( .accentColor )
                .buttonStyle( .borderedProminent )
                .controlSize( .large )
            }
            .padding( [ .top, .leading, .trailing ] )
            .padding( .bottom, 0 )
            
            // render controls section
            if( type( of: self.controls ) != EmptyView.self )
            {
                VStack( alignment: .leading )
                {
                    Text( "Controls" )
                        .font( .headline )
                    
                    self.controls
                }
                .padding( [ .top, .leading, .trailing ] )
                .padding( .bottom, 0 )
            }
            
            VStack( alignment: .leading )
            {
                let references = data.references ?? [];
                
                Text( "Featured repositories" )
                    .font( .headline )
                
                CodeReferenceListView( references: references );
            }
            .padding( [ .top, .leading, .trailing ] )
            .padding( [ .bottom ], 0 )
            
            Spacer()
            
            if( sample.credits != nil )
            {
                ImageCreditView( credits: sample.credits! );
            }
        }
    }
}

struct ReferencesView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ReferencesView()
            .environmentObject( VisionPreviewProperties() )
    }
}
