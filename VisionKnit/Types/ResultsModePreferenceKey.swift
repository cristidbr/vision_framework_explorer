//
//  ResultsModePreferenceKey.swift
//  VisionKnit
//

import Foundation
import SwiftUI

struct ResultsModePreferenceKey: PreferenceKey {
    typealias Value = ResultsViewMode
    static var defaultValue: Value = .overlay

    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value = nextValue()
    }
}
