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

        VStack(alignment: .leading) {
            let title_name = (data.named == nil) ? data.title : data.named!
            let doc_url = "https://developer.apple.com/documentation/vision/\( data.title.lowercased() )"

            VStack(alignment: .leading) {
                Text(title_name)
                    .font(.title)
                    .padding(.bottom, 8)

                Text(data.description)
                    .font(.body)

                Button {
                    openURLInBrowser(doc_url)
                } label: {
                    Label(data.title, systemImage: "arrow.up.right.square")
                }
                .tint(.accentColor)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
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
                let references = data.references ?? []

                Text("Featured repositories")
                    .font(.headline)

                CodeReferenceListView(references: references)
            }
            .padding([.top, .leading, .trailing])
            .padding([.bottom], 0)

            Spacer()

            if sample.credits != nil
                && isUserUploadedImage(uploads: properties.userUploads, selected: properties.selectedSample)
                == false
            {
                ImageCreditView(credits: sample.credits!)
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
