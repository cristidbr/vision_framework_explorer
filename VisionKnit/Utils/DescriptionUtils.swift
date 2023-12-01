//
//  DescriptionUtils.swift
//  VisionKnit
//

import Foundation

func getSelectedMethod(_ selected: UUID?) -> VisionMethodDescription? {
    let index = VisionAPIDescription.firstIndex(where: { $0.id == selected })
    
    #if os(macOS)
    return VisionAPIDescription[index ?? 0]
    #elseif os(iOS) || os(tvOS)
    if index == nil {
        return nil
    }
    
    return VisionAPIDescription[index ?? 0]
    #endif
}

func getSelectedImageSampleByMethod(_ method: UUID?, selected: UUID? = nil) -> ImageSampleReference? {
    let method = getSelectedMethod(method)
    
    if method == nil {
        return nil
    }
    
    let index = method!.samples.firstIndex(where: { $0.id == selected }) ?? 0

    return method!.samples[index]
}

func getSelectedImageUUIDByMethod(_ method: UUID?, uploads: [ImageUserUpload], selected: UUID? = nil)
  -> UUID?
{
    let upload_index = uploads.firstIndex(where: { $0.id == selected }) ?? -1

    if upload_index >= 0 {
        return uploads[upload_index].id
    }

    return getSelectedImageSampleByMethod(method, selected: selected)?.id
}

func isUserUploadedImage(uploads: [ImageUserUpload], selected: UUID?) -> Bool {
    return (uploads.firstIndex(where: { $0.id == selected }) ?? -1) >= 0
}

func getSelectedImageUserUploaded(uploads: [ImageUserUpload], selected: UUID?) -> ImageUserUpload? {
    let upload_index = uploads.firstIndex(where: { $0.id == selected }) ?? -1

    if upload_index >= 0 {
        return uploads[upload_index]
    }

    return nil
}
