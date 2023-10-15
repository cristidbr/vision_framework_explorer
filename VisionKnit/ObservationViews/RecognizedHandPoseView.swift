//
//  RecognizedHandPoseView.swift
//  VisionKnit
//

import SwiftUI
import Vision

struct RecognizedHandPoseView: View {
    let observation: VNHumanHandPoseObservation
    let areaSize: CGSize

    var body: some View {
        let path = observation.toDrawableCGPath()
        var transform = CGAffineTransform(scaleX: areaSize.width, y: areaSize.height)

        Path(path.copy(using: &transform) ?? path)
            .stroke(Color.accentColor, lineWidth: 2)
    }
}

struct RecognizedHandPoseView_Previews: PreviewProvider {
    static var previews: some View {
        Text("No preview")
    }
}
