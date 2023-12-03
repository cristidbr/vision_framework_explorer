//
//  DeviceSizing.swift
//  VisionKnit
//

import Foundation

struct DeviceSizing
{
    public var galleryHeight: CGFloat
    public var galleryPadding: CGFloat
    public var gallerySpacing: CGFloat
    public var codeReferenceStarPadding: CGFloat
    
    init() {
        self.galleryHeight = 120
        self.galleryPadding = 8
        self.gallerySpacing = 4
        self.codeReferenceStarPadding = 0
        
        #if os(macOS)
        self.galleryPadding = 6
        #elseif os(tvOS)
        self.galleryHeight = 200
        self.galleryPadding = 16
        self.gallerySpacing = 16
        self.codeReferenceStarPadding = 8
        #endif
    }
}
