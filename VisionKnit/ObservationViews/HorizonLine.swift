//
//  HorizonLine.swift
//  VisionKnit
//

import SwiftUI
import Vision

struct HorizonLine: Shape {
    public let transform: CGAffineTransform
    public let imageSize: CGSize

    func path(in area: CGRect) -> Path {
        let vw = Int(area.width)
        let vh = Int(area.height)

        var path = Path()
        let begin = VNImagePointForNormalizedPoint(CGPoint(x: -0.5, y: 0.5), vw, vh)
        let end = VNImagePointForNormalizedPoint(CGPoint(x: 1.5, y: 0.5), vw, vh)

        let areaTransform = CGAffineTransform(
            a: transform.a, b: transform.b, c: transform.c, d: transform.d, tx: 0,
            ty: transform.ty / imageSize.height * Double(vh))

        path.move(to: begin.applying(areaTransform))
        path.addLine(to: end.applying(areaTransform))

        return path
    }
}

#Preview {
    EmptyView()
}
