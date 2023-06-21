//
//  ImageCredits.swift
//  VisionKnit
//

import Foundation
//TODO: Remove white space and ";"
struct ImageCredits: Hashable, Identifiable
{
   
    let id: UUID = UUID();
    let author: String;
    let authorURL: String;
    let service: String;
    let serviceURL: String;
}
