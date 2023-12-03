//
//  ImageCreditView.swift
//  VisionKnit
//

import SwiftUI

struct ImageCreditView: View {
    let credits: ImageCredits

    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "info.circle")
                .font(.footnote)
                .opacity(0.64)

            Text("Photo by")
                .font(.footnote)
                .opacity(0.64)

            Button {
                openURLInBrowser(credits.authorURL)
            } label: {
                Text(credits.author)
                    .font(.footnote)
                    .underline(true, color: Color.gray.opacity(0.37))
                    .lineLimit(1)
            }
            .buttonStyle(.plain)

            Text("on")
                .font(.footnote)
                .opacity(0.64)

            Button {
                openURLInBrowser(credits.serviceURL)
            } label: {
                Text(credits.service)
                    .font(.footnote)
                    .underline(true, color: Color.gray.opacity(0.37))
                    .lineLimit(1)
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct ImageCreditView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCreditView(
            credits: ImageCredits(
                author: "Amanda Moreno", authorURL: "https://google.com", service: "Unsplash",
                serviceURL: "https://google.com"))
    }
}
