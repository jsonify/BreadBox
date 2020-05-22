//
//  Ingredient.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/22/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct Ingredient: View {
    var type: String
    @Binding var typeAmount: String
    
    var body: some View {
        VStack {
            HStack {
                Text("\(type):".uppercased())
                    .font(AvFont.title)
                    .bold()
                    .tracking(0.5)
                
                Spacer()
            }
            
            HStack {
                TextField("", text: $typeAmount)
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1))))
                    .foregroundColor(Color("textField"))
                    .frame(width: 120, height: 34)
                    .font(.caption)
                .keyboardType(.decimalPad)
                
                Text("Grams".uppercased())
                    .font(AvFont.title)
                    .bold()
                    .tracking(0.5)
                
                Spacer()
            }
            
        }
        .padding(.leading, 30)
    }
}
