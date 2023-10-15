//
//  ConfidenceLabelView.swift
//  VisionKnit
//

import SwiftUI

struct ConfidenceLabelView: View {
    public let text: String
    public let confidence: Double

    public init(_ text: String = "", confidence: Double = 1.0) {
        self.text = text
        self.confidence = confidence
    }

    var body: some View {
        Rectangle()
            .fill(Color.accentColor.opacity(0.64))
            .overlay {
                ConfidenceProgress(confidence: confidence)
                    .fill(Color.accentColor.opacity(1.00))
            }
            .overlay {
                Text(text)
                    .padding(2)
                    .scaledToFit()
                    .minimumScaleFactor(0.01)
                    .foregroundColor(.white)
            }
    }
}

struct ConfidenceLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ConfidenceLabelView("Data", confidence: 0.75)
            .frame(width: 200, height: 20)
    }
}
