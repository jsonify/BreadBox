//
//  CustomTextField.swift
//  Breader
//
//  Created by Jason Rueckert on 5/13/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct CustomTextField: View {
    var placeHolder: String
    @Binding var value: String

    var lineColor: Color
    var width: CGFloat

    var body: some View {
        VStack {
            TextField(self.placeHolder, text: $value)

            Rectangle().frame(height: self.width)
                .foregroundColor(self.lineColor)
        }
    }
}
