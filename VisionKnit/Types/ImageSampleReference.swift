//
//  ImageSampleReference.swift
//  VisionKnit
//

import Foundation
//TODO: Remove white space and ";"
struct ImageSampleReference : Hashable, Identifiable
{
    
    let id: UUID = UUID();
    
    let path: String;
    let credits: ImageCredits?;
    let darkVersion: Bool;
    
    init( path: String, credits: ImageCredits? = nil, darkVersion: Bool = false )
    {
        self.path = path
        self.credits = credits
        self.darkVersion = darkVersion;
    }
}
