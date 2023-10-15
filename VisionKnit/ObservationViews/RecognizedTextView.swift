//
//  TextRecognitionView.swift
//  VisionKnit
//

import SwiftUI

struct RecognizedTextView: View {
    let text: String
    let boundingBox: CGRect
    let rotation: Double

    public init(_ text: String = "", boundingBox: CGRect = CGRect.null, rotation: Double = 0) {
        self.text = text
        self.boundingBox = boundingBox
        self.rotation = rotation
    }

    var body: some View {
        let rect = RoundedRectangle(cornerRadius: 2)
            .fill(Color.clear)
            .overlay {
                Text(text)
                .minimumScaleFactor(0.01)
                .scaledToFit()
            }

        if boundingBox != CGRect.null {
            rect
                .frame(width: boundingBox.width, height: boundingBox.height)
                .padding(2)
                .border(Color.accentColor, width: 2)
                .cornerRadius(2)
                .rotationEffect(.radians(rotation))
                .position(x: boundingBox.midX, y: boundingBox.midY)
        } else {
            rect
        }
    }
}

struct RecognizedTextView_Previews: PreviewProvider {
    static var previews: some View {
        RecognizedTextView("OCR Text", boundingBox: .init(x: 100, y: 75, width: 50, height: 25))
    }
}
