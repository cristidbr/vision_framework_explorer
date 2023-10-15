//
//  QuadrilateralPoly.swift
//  VisionKnit
//

import SwiftUI
import Vision

struct QuadrilateralPoly: Shape {
    public let topLeft: CGPoint
    public let bottomLeft: CGPoint
    public let bottomRight: CGPoint
    public let topRight: CGPoint

    func path(in area: CGRect) -> Path {
        let vw = Int(area.width)
        let vh = Int(area.height)

        var path = Path()

        path.move(to: VNImagePointForNormalizedPoint(topLeft, vw, vh))
        path.addLine(to: VNImagePointForNormalizedPoint(bottomLeft, vw, vh))
        path.addLine(to: VNImagePointForNormalizedPoint(bottomRight, vw, vh))
        path.addLine(to: VNImagePointForNormalizedPoint(topRight, vw, vh))
        path.addLine(to: VNImagePointForNormalizedPoint(topLeft, vw, vh))

        return path
    }
}

#Preview {
    EmptyView()
}
