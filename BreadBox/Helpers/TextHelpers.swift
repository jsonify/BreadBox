//
//  TextHelpers.swift
//  BreadBox
//
//  Created by Jason Rueckert on 6/1/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 5){
        characterLimit = limit
    }
}

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


struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {

        let myTextView = UITextView()
        myTextView.delegate = context.coordinator

        myTextView.font = UIFont(name: "Avenir", size: 16)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = UIColor(named: "textViewBackground")
        myTextView.text = "Placeholder"
        myTextView.textColor = UIColor(named: "textField")

        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
//            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = nil
                textView.textColor = UIColor.black
            }
        }
    }
}
