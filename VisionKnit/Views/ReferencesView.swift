//
//  ReferencesView.swift
//  VisionKnit
//

import SwiftUI

struct ReferencesView<Controls>: View where Controls: View {
    @EnvironmentObject var properties: VisionPreviewProperties

    let controls: Controls

    init(@ViewBuilder controls: () -> Controls) {
        self.controls = controls()
    }

    init() where Controls == EmptyView {
        self.controls = EmptyView()
    }

    var body: some View {
        let data = getSelectedMethod(properties.selectedMethod)
        let sample = getSelectedImageSampleByMethod(
            properties.selectedMethod, selected: properties.selectedSample)
        
        if data == nil
        {
            VStack(alignment: .center) {
                Spacer()
                Text("Select operation")
                Spacer()
            }
        }
        else
        {
            let render = data!
            let title_name = (render.named == nil) ? render.title : render.named!
            let doc_url = "https://developer.apple.com/documentation/vision/\( render.title.lowercased() )"
            
            GeometryReader
            {
                geometry in
                ScrollView(.vertical)
                {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(title_name)
                                .font(.title)
                                .padding(.bottom, 8)
                            
                            Text(render.description)
                                .font(.body)
                            
                            #if os(macOS) || os(iOS)
                            Button {
                                openURLInBrowser(doc_url)
                            } label: {
                                Label(render.title, systemImage: "arrow.up.right.square")
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            .tint(.accentColor)
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            #else
                            Button {
                                
                            } label: {
                                Label(render.title, systemImage: "arrow.up.right.square")
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            .tint(.accentColor)
                            .buttonStyle(.borderedProminent)
                            #endif
                        }
                        .padding([.top, .leading, .trailing])
                        .padding(.bottom, 0)
                        
                        // render controls section
                        if type(of: self.controls) != EmptyView.self {
                            VStack(alignment: .leading) {
                                Text("Controls")
                                    .font(.headline)
                                
                                self.controls
                            }
                            .padding([.top, .leading, .trailing])
                            .padding(.bottom, 0)
                        }
                        
                        VStack(alignment: .leading) {
                            let references = render.references ?? []
                            
                            Text("Featured repositories")
                                .font(.headline)
                            
                            CodeReferenceListView(references: references)
                        }
                        .padding([.top, .leading, .trailing])
                        .padding([.bottom], 0)
                        
                        Spacer()
                            .frame(maxHeight: .infinity)
                        
                        if sample?.credits != nil
                            && isUserUploadedImage(uploads: properties.userUploads, selected: properties.selectedSample)
                            == false
                        {
                            ImageCreditView(credits: sample!.credits!)
                        }
                    }
                    .frame(minHeight: geometry.size.height)
                }
            }
        }
    }
}

struct ReferencesView_Previews: PreviewProvider {
    static var previews: some View {
        ReferencesView()
        .environmentObject(VisionPreviewProperties())
    }
}
