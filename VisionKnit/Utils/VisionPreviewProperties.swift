//
//  VisionPreviewProperties.swift
//  VisionKnit
//

import CoreGraphics
import Foundation

@MainActor class VisionPreviewProperties: ObservableObject {
    @Published var selectedMethod: UUID? = getSelectedMethod(UUID())?.id
    @Published var selectedSample: UUID? = getSelectedMethod(UUID())?.id

    @Published var userUploads: [ImageUserUpload] = []
}

