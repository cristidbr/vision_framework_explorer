//
//  CodeReferenceListView.swift
//  VisionKnit
//

import SwiftUI

struct CodeReferenceListView: View {
    let references: [CodeReference]

    var body: some View {
        let references_sorted = references.sorted()

        VStack(spacing: 0) {
            ForEach(0..<references_sorted.count, id: \.self) {
                idx in
                    let reference = references_sorted[idx]

                    Button {
                        openURLInBrowser(reference.url)
                    } label: {
                        HStack(spacing: 8) {
                            if reference.ranking != nil {
                            Image(systemName: "star.fill")
                                .font(.callout)
                                
                            Text(String(reference.ranking!))
                                .font(.footnote)
                            }

                            Text(reference.url.replacingOccurrences(of: "https://", with: ""))
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .padding(.leading, DeviceSizing().codeReferenceStarPadding)
                            
                            Spacer()
                        }
                        .padding(.all, 8)
                    }
                    .buttonStyle(.plain)
                    .background(
                        RoundedRectangle(cornerRadius: 6).fill(
                            (idx % 2 == 0) ? Color.gray.opacity(0.2) : Color.clear))
            }
            
            Spacer()
        }
        .padding([.top, .bottom], 0)
    }
}

#Preview {
    CodeReferenceListView(references: [])
}
