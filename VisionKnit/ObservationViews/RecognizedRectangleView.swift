//
//  RecognizedRectangleView.swift
//  VisionKnit
//

import SwiftUI

struct RecognizedRectangleView: View {
    let label: String
    let boundingBox: CGRect

    public init(_ label: String = "", boundingBox: CGRect = CGRect.null) {
        self.label = label
        self.boundingBox = boundingBox
    }

    var body: some View {
        let label = Text("\( label )")
            .font(.footnote)
            .padding([.top, .bottom], 2)
            .padding([.leading, .trailing], 4)
            .background(Color.accentColor)
            .cornerRadius(2)
            .scaledToFit()
            .minimumScaleFactor(0.01)
            .foregroundColor(.white)
            .opacity(label == "" ? 0 : 1)

        let rect = RoundedRectangle(cornerRadius: 2)
            .stroke(Color.accentColor, lineWidth: 2)

        if boundingBox != CGRect.null {
            rect
                .frame(width: boundingBox.width, height: boundingBox.height)
                .position(x: boundingBox.midX, y: boundingBox.midY)
                .overlay {
                    label
                        .frame(maxWidth: max(0, boundingBox.width - 8))
                        .position(x: boundingBox.midX, y: boundingBox.minY)
                }
        } else {
            rect
                .overlay {
                    label
                }
        }
    }
}

struct RecognizedRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RecognizedRectangleView("Giraffe", boundingBox: CGRect.null)
    }
}
