//
//  Haptic.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/22/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

class Haptic {
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func simpleWarning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
}
