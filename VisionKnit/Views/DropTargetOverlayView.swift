//
//  DropTargetOverlayView.swift
//  VisionKnit
//

import SwiftUI

struct DropTargetOverlayView: View {
    var body: some View {
        Color.black.opacity(0.2)
            .overlay {
                VStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "tray.and.arrow.down")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .colorInvert()

                    Text("Drop Here")
                        .font(.system(.title2))
                        .colorInvert()

                    Spacer()
                }
            }
    }
}

#Preview {
    DropTargetOverlayView()
}
