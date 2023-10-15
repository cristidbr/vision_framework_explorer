//
//  ContoursView.swift
//  VisionKnit
//

import SwiftUI
import Vision

struct ContoursView: View {
    let observation: VNContoursObservation
    let areaSize: CGSize

    init(observation: VNContoursObservation, areaSize: CGSize) {
        self.observation = observation
        self.areaSize = areaSize
    }

    var body: some View {
        Canvas {
        context, size in

        var transform = CGAffineTransform(scaleX: size.width, y: size.height)

        let (top_path, sub_path) = observation.toDrawableCGPaths()

        context.stroke(
            Path(top_path.copy(using: &transform) ?? top_path), with: .color(Color.accentColor),
            lineWidth: 2)

        context.stroke(
            Path(sub_path.copy(using: &transform) ?? sub_path), with: .color(Color.accentColor),
            lineWidth: 1)
        }
        .frame(width: areaSize.width, height: areaSize.height)
    }
}

struct ContoursView_Previews: PreviewProvider {
    static var previews: some View {
        Text("No preview")
    }
}
