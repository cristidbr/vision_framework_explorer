//
//  VisionMethodDescription.swift
//  VisionKnit
//

import Foundation

struct VisionMethodDescription: Hashable, Identifiable {
    let id = UUID()

    let path: String
    let named: String?
    let icon: String?

    let title: String
    let description: String

    let preview: ResultsViewMode
    let references: [CodeReference]?
    let samples: [ImageSampleReference]
}
