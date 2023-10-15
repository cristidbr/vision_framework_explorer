//
//  FaceUtils.swift
//  VisionKnit
//

import Foundation
import Vision

extension VNFaceLandmarkRegion2D {
    public func drawCGPathContour(path: inout CGMutablePath, preventClose: Bool = false) {
        let points =
        
        self
            .pointsInImage(imageSize: CGSize(width: 1.0, height: 1.0))
            .map { CGPoint(x: $0.x, y: 1.0 - $0.y) }

        if self.pointsClassification != .disconnected {
            if points.count > 1 {
                path.move(to: points[0])

                for point in points {
                    path.addLine(to: point)
                }

                if !preventClose {
                    path.closeSubpath()
                }
            }
        }
    }
}

extension VNFaceObservation {
    public func getFaceLandmarkRegion(_ key: String) -> VNFaceLandmarkRegion2D? {
        if let landmarks = self.landmarks {
            if let region = landmarks.value(forKey: key) as? VNFaceLandmarkRegion2D {
                return region
            }
        }

        return nil
    }

    public func toCGPointsInArea(areaSize: CGSize) -> [CGPoint] {
        var points: [CGPoint] = []

        if let region = self.getFaceLandmarkRegion("allPoints") {
            points += region.pointsInImage(imageSize: areaSize).map {
                CGPoint(x: $0.x, y: areaSize.height - $0.y)
            }
        }

        return points
    }

    public func toDrawableCGPath() -> CGPath {
        let contours = [
            "faceContour", "leftEye", "rightEye", "leftEyebrow", "rightEyebrow", "nose", "outerLips",
            "innerLips", "leftPupil", "rightPupil",
        ]

        var path = CGMutablePath()

        for contour in contours {
            if let region = self.getFaceLandmarkRegion(contour) {
                region.drawCGPathContour(path: &path, preventClose: contour == "faceContour")
            }
        }

        return path
    }
}
