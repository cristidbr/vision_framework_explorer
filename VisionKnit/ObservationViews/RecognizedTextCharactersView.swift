//
//  TextRecognitionView.swift
//  VisionKnit
//

import CoreGraphics
import SwiftUI

struct RecognizedTextCharactersView: View {
    let text: String
    let uuid: UUID
    let cgImage: CGImage
    let boundingBox: CGRect
    let characterBoxes: [CGRect]
    let rotation: Double

    public init(
        _ text: String = "", uuid: UUID, cgImage: CGImage, boundingBox: CGRect = CGRect.null,
        characterBoxes: [CGRect] = [], rotation: Double = 0
    ) {
        self.text = text
        self.cgImage = cgImage
        self.uuid = uuid
        self.boundingBox = boundingBox
        self.characterBoxes = characterBoxes.filter { min($0.width, $0.height) > 2 }
        self.rotation = rotation
    }

    var body: some View {
        let rowlimit = 9
        let glayout: [GridItem] = Array(
            repeating: .init(.adaptive(minimum: boundingBox.height)),
            count: min(rowlimit, self.characterBoxes.count))

        VStack(spacing: 8) {
            makeMain()

            LazyVGrid(columns: glayout, alignment: .center, spacing: 4) {
                ForEach(0..<self.characterBoxes.count, id: \.self) {
                    idx in

                    let crect = self.characterBoxes[idx]
                    let cimg = cgImage.cropping(to: crect) ?? cgImage

                    Image(decorative: cimg, scale: 1.0)
                        .resizable()
                        .frame(maxHeight: boundingBox.height)
                        .minimumScaleFactor(0.01)
                        .scaledToFit()
                }
            }
        }
    }

    @ViewBuilder func makeMain() -> some View {
        let cimg = cgImage.cropping(to: boundingBox) ?? cgImage

        Image(decorative: cimg, scale: 1.0)
            .resizable()
            .minimumScaleFactor(0.01)
            .scaledToFit()
            .overlay {
                RoundedRectangle(cornerRadius: 2)
                .stroke(Color.accentColor, lineWidth: 2)
            }
            .frame(maxWidth: boundingBox.width, maxHeight: boundingBox.height)
    }
}

struct RecognizedTextCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        RecognizedTextCharactersView(
            "OCR Text", uuid: UUID(), cgImage: loadCGImage(VisionAPIDescription[0].samples[0].path),
            boundingBox: .init(x: 100, y: 75, width: 50, height: 25))
    }
}
