//
//  FeaturePrintView.swift
//  VisionKnit
//

import SwiftUI

struct FeaturePrintView: View {
    let graph: CGPath

    init(_ graph: CGPath) {
        self.graph = graph
    }

    var body: some View {
        GeometryReader {
            geometry in
            var transform = CGAffineTransform(scaleX: geometry.size.width, y: geometry.size.height)

            Path(graph.copy(using: &transform) ?? graph)
                .fill(Color.accentColor)
        }
    }
}

struct FeaturePrintView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
