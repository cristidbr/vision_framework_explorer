//
//  HorizonLineView.swift
//  VisionKnit
//

import SwiftUI
import Vision

struct HorizonLineView: View {
    let transform: CGAffineTransform
    let rotationAngle: CGFloat
    let cgImage: CGImage

    public init(_ transform: CGAffineTransform, rotationAngle: CGFloat, cgImage: CGImage) {
        self.transform = transform
        self.rotationAngle = rotationAngle
        self.cgImage = cgImage
    }

    var body: some View {
        ZStack {
            Image(decorative: cgImage, scale: 1.0)
                .antialiased(true)
                .resizable()
                .scaledToFit()
                .cornerRadius(4)

            HorizonLine(
                transform: transform, imageSize: CGSize(width: cgImage.width, height: cgImage.height)
            )
            .stroke(Color.accentColor, lineWidth: 2)
        }
        .rotationEffect(.radians(-rotationAngle))
    }
}

struct HorizonLineView_Previews: PreviewProvider {
    static var previews: some View {
        HorizonLineView(.identity, rotationAngle: 0, cgImage: loadCGImage("op-img-detect-horizon-1"))
    }
}
