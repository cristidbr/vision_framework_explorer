//
//  VisionOperations.swift
//  VisionKnit
//

import CoreGraphics
import Foundation
import Vision

#if canImport(AppKit)
    import AppKit
#endif

#if canImport(UIKit)
    import UIKit
#endif

func makeVisionRequest(path: String) -> VNImageBasedRequest {
    var task: VNImageBasedRequest

    switch path
    {
    case "classify":
        task = VNClassifyImageRequest()
    case "barcodes":
        task = VNDetectBarcodesRequest()
    case "document-segmentation":
        task = VNDetectDocumentSegmentationRequest()
    case "ocr":
        task = VNRecognizeTextRequest()
    case "human-segmentation":
        task = VNGeneratePersonSegmentationRequest()
    case "text-rectangles":
        let vtask = VNDetectTextRectanglesRequest()
        vtask.reportCharacterBoxes = true
        task = vtask
    case "face-rectangles":
        task = VNDetectFaceRectanglesRequest()
    case "face-quality":
        task = VNDetectFaceCaptureQualityRequest()
    case "face-landmarks":
        task = VNDetectFaceLandmarksRequest()
    case "horizon":
        task = VNDetectHorizonRequest()
    case "humans":
        task = VNDetectHumanRectanglesRequest()
    case "animals":
        task = VNRecognizeAnimalsRequest()
    case "rectangles":
        let vtask = VNDetectRectanglesRequest()
        vtask.maximumObservations = 16
        vtask.minimumAspectRatio = 0.2
        vtask.maximumAspectRatio = 0.8
        vtask.minimumSize = 0.1
        task = vtask
    case "human-body-pose":
        task = VNDetectHumanBodyPoseRequest()
    case "human-hand-pose":
        let vtask = VNDetectHumanHandPoseRequest()
        vtask.maximumHandCount = 8
        task = vtask
    case "contours":
        let vtask = VNDetectContoursRequest()
        vtask.maximumImageDimension = 512
        task = vtask
    case "feature-print":
        task = VNGenerateImageFeaturePrintRequest()
    case "attention-saliency":
        task = VNGenerateAttentionBasedSaliencyImageRequest()
    case "objectness-saliency":
        task = VNGenerateObjectnessBasedSaliencyImageRequest()
    case "core-ml-unsupported":
        // TODO: add support
        task = VNImageBasedRequest()
    default:
        task = VNImageBasedRequest()
    }

    return task
}

func executeVisionRequest(
  cgImage: CGImage, request: VNImageBasedRequest, callback: @escaping ([VNObservation]?) -> Void
) {
    Task(priority: .userInitiated) {
        let rhandle = VNImageRequestHandler(cgImage: cgImage)

        do {
            try rhandle.perform([request])
        } catch {
            callback(nil)

            return
        }

        callback(request.results ?? [] as [VNObservation])
    }
}

func loadCGImage(_ path: String) -> CGImage {
    #if canImport(AppKit)
        let nsimage = NSImage(named: path)
        var area = NSRect(x: 0, y: 0, width: (nsimage?.size.width)!, height: (nsimage?.size.height)!)
        let image = nsimage?.cgImage(forProposedRect: &area, context: NSGraphicsContext(), hints: [:])

        return image!
    #endif

    #if canImport(UIKit)
        let uiimage = UIImage(named: path)
        return (uiimage?.cgImage)!
    #endif
}

#if canImport(AppKit)
func loadCGImage(_ nsimage: NSImage) -> CGImage {
    var area = NSRect(x: 0, y: 0, width: (nsimage.size.width), height: (nsimage.size.height))
    let image = nsimage.cgImage(forProposedRect: &area, context: NSGraphicsContext(), hints: [:])

    return image!
}
#endif

func loadCGImageFallback(_ path: String, uploads: [ImageUserUpload], selected: UUID) -> CGImage {
    if let userUpload = getSelectedImageUserUploaded(uploads: uploads, selected: selected) {
        return userUpload.image
    }

    return loadCGImage(path)
}
