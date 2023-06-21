//
//  VisionPreviewProperties.swift
//  VisionKnit
//

import Foundation
//TODO: Remove white ";"
@MainActor class VisionPreviewProperties: ObservableObject
{
    @Published var selectedMethod: UUID = getSelectedMethod( UUID() ).id;
    @Published var selectedSample: UUID = getSelectedMethod( UUID() ).id;
}
