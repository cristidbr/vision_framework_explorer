//
//  URLUtils.swift
//  VisionKnit
//

import Foundation

#if canImport(UIKit)
    import UIKit
    import SafariServices
#elseif canImport(AppKit)
    import AppKit
#endif

func openURLInBrowser(_ urlString: String) {
    guard let url = URL(string: urlString) else {
        return
    }

    #if canImport(UIKit)
        let viewController = SFSafariViewController(url: url)

        UIApplication.shared.windows.first?.rootViewController?.present(
        viewController, animated: true, completion: nil)
    #elseif canImport(AppKit)
        NSWorkspace.shared.open(url)
    #endif
}
