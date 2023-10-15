//
//  ReviewUtils.swift
//  VisionKnit
//

import Foundation

func shouldShowReviewDialog() -> Bool {
    let userDefaults = UserDefaults.standard
    let reviewShown = userDefaults.bool(forKey: "reviewShown")
    let appInteractions = userDefaults.integer(forKey: "operationChangedCount")

    if appInteractions > 6 && !reviewShown {
        userDefaults.set(true, forKey: "reviewShown")

        return true
    }

    return false
}

func incrementInteractions() {
    let userDefaults = UserDefaults.standard
    var appInteractions = userDefaults.integer(forKey: "operationChangedCount")

    appInteractions += 1

    userDefaults.set(appInteractions, forKey: "operationChangedCount")
}

func resetUserStorageKeys() {
    let userDefaults = UserDefaults.standard

    userDefaults.set(false, forKey: "reviewShown")
    userDefaults.set(0, forKey: "operationChangedCount")
}
