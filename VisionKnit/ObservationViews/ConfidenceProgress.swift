//
//  ConfidenceProgress.swift
//  VisionKnit
//

import SwiftUI

struct ConfidenceProgress: Shape {
    public let confidence: Double

    func path(in area: CGRect) -> Path {
        return Path(CGRect(x: 0, y: 0, width: confidence * area.width, height: area.height))
    }
}

#Preview {
    EmptyView()
}
