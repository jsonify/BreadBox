//
//  StoreKitHelper.swift
//  BreadBox
//
//  Created by Jason Rueckert on 4/27/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import Foundation
import StoreKit

struct StoreKitHelper {
    static let numberOfTimesLaunchedKey = "numberOfTimesLaunched"
    
    static func displayStoreKit() {
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String else {
            return
        }
        
        let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: "lastVersion")
        let numberOfTimesLaunched: Int = UserDefaults.standard.integer(forKey: StoreKitHelper.numberOfTimesLaunchedKey)
        
        if numberOfTimesLaunched == 2 && currentVersion != lastVersionPromptedForReview {
            SKStoreReviewController.requestReview()
            UserDefaults.standard.set(currentVersion, forKey: "lastVersion")
        }
    }
    
    static func incrementNumberOfTimesLaunched() {
        let numberOfTimesLanched: Int = UserDefaults.standard.integer(forKey: StoreKitHelper.numberOfTimesLaunchedKey) + 1
        UserDefaults.standard.set(numberOfTimesLanched, forKey: StoreKitHelper.numberOfTimesLaunchedKey)
    }
}
