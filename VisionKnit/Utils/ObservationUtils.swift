//
//  VNObservationUtils.swift
//  VisionKnit
//

import CoreGraphics
import Foundation
import SwiftUI
import Vision

func barcodeSymbologyToString(_ symbology: VNBarcodeSymbology) -> String {
    return String(symbology as NSString).replacingOccurrences(of: "VNBarcodeSymbology", with: "")
}

func observationBoundingBoxToArea(_ boundingBox: CGRect, areaSize: CGSize) -> CGRect {
    let rect = VNImageRectForNormalizedRect(boundingBox, Int(areaSize.width), Int(areaSize.height))

    return
        rect
        .applying(
            CGAffineTransformTranslate(
                CGAffineTransformMakeScale(1, -1),
                0,
                -areaSize.height
            )
        )
}

func observationPointToImagePoint(_ point: CGPoint, size: CGSize) -> CGPoint {
    VNImagePointForNormalizedPoint(observationPointInvertY(point), Int(size.width), Int(size.height))
}

func observationPointInvertY(_ point: CGPoint) -> CGPoint {
    return CGPoint(x: point.x, y: 1.0 - point.y)
}

func angleBetweenPoints(_ origin: CGPoint, _ comparison: CGPoint) -> Double {
    let deltaX = origin.x - comparison.x
    let deltaY = origin.y - comparison.y

    return atan2(deltaY, deltaX)
}

func distanceBetweenPoints(_ from: CGPoint, _ to: CGPoint) -> Double {
    let deltaX = from.x - to.x
    let deltaY = from.y - to.y

    return sqrt(pow(deltaX, 2) + pow(deltaY, 2))
}

func observationMeasureCornerPointsBoxRotatedSize(
    topLeft: CGPoint, bottomLeft: CGPoint, bottomRight: CGPoint, topRight: CGPoint
) -> CGSize {
    let width = distanceBetweenPoints(topLeft, topRight)
    let height = distanceBetweenPoints(topLeft, bottomLeft)

    return CGSize(width: Int(width), height: Int(height))
}
