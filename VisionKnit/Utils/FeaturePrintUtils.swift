//
//  FeaturePrintUtils.swift
//  VisionKnit
//

import Foundation
import Vision

extension VNFeaturePrintObservation {
    public func toDrawableCGPath() -> CGPath {
        let path = CGMutablePath()

        let numeric = self.data.withUnsafeBytes { Array($0.bindMemory(to: Float.self)) }
        let data = numeric.compactMap { Double($0) }

        let elements = Double(data.count)
        let minval = data.min() ?? 0
        let maxval = data.max() ?? 1

        path.move(to: CGPoint(x: 0, y: 0))

        for column in 0..<data.count {
            var val = abs(data[column])

            val = val / max(abs(minval), maxval)

            path.addLine(to: CGPoint(x: val, y: Double(column) / elements))
            path.addLine(to: CGPoint(x: val, y: Double(column + 1) / elements))
        }

        path.addLine(to: CGPoint(x: 0, y: 1))
        path.closeSubpath()

        return path
    }
}
