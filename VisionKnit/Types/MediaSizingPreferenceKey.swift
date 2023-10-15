//
//  MediaSizingPreferenceKey.swift
//  VisionKnit
//

import SwiftUI

struct MediaSizingPreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero

    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value = nextValue()
    }
}
