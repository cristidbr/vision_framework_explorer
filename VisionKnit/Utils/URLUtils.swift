//
//  URLUtils.swift
//  VisionKnit
//

import Foundation

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

#if os(iOS)
    import SafariServices
#endif


func openURLInBrowser(_ urlString: String) {
    guard let url = URL(string: urlString) else {
        return
    }

    #if os(iOS)
        let viewController = SFSafariViewController(url: url)
    
        UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?
            .keyWindow?
            .rootViewController?.present(
                viewController, animated: true, completion: nil)
    #elseif os(macOS)
        NSWorkspace.shared.open(url)
    #endif
}
