//
//  ResultsViewMode.swift
//  VisionKnit
//

import Foundation

enum ResultsViewMode : Hashable
{
    case overlay, trailing, split, bottom;
    
    func next( ) -> ResultsViewMode
    {
        switch self
        {
        case .overlay:
            return .trailing
        case .trailing:
            return .split
        case .split:
            return .bottom
        case .bottom:
            return .overlay
        }
    }
}

