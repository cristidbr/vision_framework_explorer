//
//  RenderingView.swift
//  VisionKnit
//

import StoreKit
import SwiftUI
import Vision

struct RenderingView: View {
    #if os(macOS) || os(iOS)
    @Environment(\.requestReview) var requestReview
    #endif
    
    @EnvironmentObject var properties: VisionPreviewProperties
    
    public let viewMode: ResultsViewMode

    @State private var results: [VNObservation]? = nil
    @State private var completed: Bool = false

    var body: some View {
        if properties.selectedMethod == nil
        {
            VStack( alignment: .center )
            {
                Spacer()
                Text( "Select operation" )
                Spacer()
            }
        }
        else
        {
            let sample_id = getSelectedImageUUIDByMethod(
                properties.selectedMethod!, uploads: properties.userUploads,
                selected: properties.selectedSample)
            let method_id = getSelectedMethod(properties.selectedMethod!)?.id
            
            if sample_id == nil || method_id == nil
            {
                Color.clear
            }
            else
            {
                let path: String = sample_id!.uuidString + method_id!.uuidString
                
                ResultsView(viewMode: viewMode) {
                    MediaView()
                } results: {
                    ResultRenderingView(results, completed: completed)
                }
                .onAppear(perform: handleVisionRequest)
                .onChange(of: path, perform: { _ in handleVisionRequest() })
            }
        }
    }

    func handleVisionRequest() {
        let methodData = getSelectedMethod(properties.selectedMethod)
        
        if methodData == nil {
            return
        }
        
        let visionRequest = makeVisionRequest(path: methodData!.path)

        let sampleData = getSelectedImageSampleByMethod(
            properties.selectedMethod!, selected: properties.selectedSample)
        
        if sampleData == nil {
            return
        }
        
        var cgImage: CGImage? = nil

        if isUserUploadedImage(uploads: properties.userUploads, selected: properties.selectedSample) {
            if methodData!.path == "core-ml-unsupported" {
                properties.selectedSample = sampleData!.id
                return
            }

            cgImage =
                getSelectedImageUserUploaded(
                    uploads: properties.userUploads, selected: properties.selectedSample!)?.image ?? nil
        } else {
            cgImage = loadCGImage(sampleData!.path)
        }

        if cgImage == nil {
            results = nil
            completed = true
            return
        }

        results = []
        completed = false

        executeVisionRequest(cgImage: cgImage!, request: visionRequest) {
            results = $0
            completed = true
        }

        incrementInteractions()

        if shouldShowReviewDialog() {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                #if os(macOS) || os(iOS)
                requestReview()
                #endif
            }
        }
    }
}

struct RenderingView_Previews: PreviewProvider {
    static var previews: some View {
        RenderingView(viewMode: .overlay)
            .environmentObject(VisionPreviewProperties())
    }
}
