//
//  RecognizedFaceLandmarksView.swift
//  VisionKnit
//

import SwiftUI

struct RecognizedFaceLandmarksView: View {
    public let points: [CGPoint]

    init(_ points: [CGPoint]) {
        self.points = points
    }

    var body: some View {
        ForEach(0..<points.count, id: \.self) {
            idx in

            let pt = points[idx]
            Circle()
                .fill(Color.accentColor)
                .frame(width: 4, height: 4)
                .position(x: pt.x, y: pt.y)
        }
    }
}

struct RecognizedFaceLandmarksView_Previews: PreviewProvider {
    static var previews: some View {
        RecognizedFaceLandmarksView([])
    }
}
