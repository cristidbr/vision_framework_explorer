//
//  RecognizedMaskView.swift
//  VisionKnit
//

import CoreImage
import SwiftUI

struct RecognizedMaskView: View {
    let pixelBuffer: CVPixelBuffer

    var body: some View {
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent)

        Image(decorative: cgImage!, scale: 1.0)
            .resizable()
            .opacity(0.5)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct RecognizedMaskView_Previews: PreviewProvider {
    static var previews: some View {
        Text("No preview")
    }
}
