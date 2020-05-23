//
//  BlurBackground.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/23/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI
struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

