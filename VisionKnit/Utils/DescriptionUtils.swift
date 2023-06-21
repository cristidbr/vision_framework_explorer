//
//  DescriptionUtils.swift
//  VisionKnit
//

import Foundation
//TODO: Remove white space and ";"
func getSelectedMethod( _ selected: UUID ) -> VisionMethodDescription
{
    let index = VisionAPIDescription.firstIndex( where: { $0.id == selected } ) ?? 0;
    
    return VisionAPIDescription[ index ];
}

func getSelectedImageSampleByMethod( _ method: UUID, selected: UUID? = nil ) -> ImageSampleReference
{
    let method = getSelectedMethod( method );
    let index = method.samples.firstIndex( where: { $0.id == selected } ) ?? 0;
    
    return method.samples[ index ];
}
