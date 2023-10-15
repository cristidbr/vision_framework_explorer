//
//  CodeReference.swift
//  VisionKnit
//

import Foundation

struct CodeReference: Hashable, Comparable, Identifiable {
    let id: UUID = UUID()

    let url: String
    let ranking: Int?

    static func < (lhs: CodeReference, rhs: CodeReference) -> Bool {
        var lrank = -1
        var rrank = -1

        if lhs.ranking != nil {
            lrank = lhs.ranking!
        }

        if rhs.ranking != nil {
            rrank = rhs.ranking!
        }

        return rrank < lrank
    }
}
