//
//  CustomFont.swift
//  Breader
//
//  Created by Jason Rueckert on 5/16/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}

struct AvFont {
    static let header = Font.custom("Avenir", size: 22)
    static let textField = Font.custom("Avenir", size: 16)
    static let title = Font.custom("Avenir", size: 12)
    static let subtitle = Font.custom("Avenir", size: 10)
}
