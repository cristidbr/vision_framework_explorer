//
//  ImageUserUpload.swift
//  VisionKnit
//

import CoreGraphics
import Foundation

struct ImageUserUpload: Identifiable {
    let id: UUID = UUID()

    let image: CGImage

    init(_ image: CGImage) {
        self.image = image
    }
}
