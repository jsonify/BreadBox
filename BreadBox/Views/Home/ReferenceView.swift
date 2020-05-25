//
//  ReferenceView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/23/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct ReferenceView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text("Reference".uppercased())
                    .font(AvFont.header)
                    .tracking(3)
                    .bold()
                
                Spacer()
                
                HStack {
                    Button(action: {
                        Haptic().simpleSuccess()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Close".uppercased())
                            .font(AvFont.subtitle)
                            .tracking(1)
                            .frame(width: 60, height: 25)
                            .background(Color("buttonGray"))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                    
                }
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            HStack {
                Text("Temperatures".uppercased())
                .font(AvFont.title)
                .tracking(3)
                    .bold()
                
            }
            
            VStack {
                TemperatureLine(first: "F", second: "C", last: "")
                Group {
                    TemperatureLine(first: "250", second: "120", last: "Very Low")
                    TemperatureLine(first: "275", second: "140", last: "")
                    TemperatureLine(first: "300", second: "150", last: "Low")
                }
                Group {
                    TemperatureLine(first: "325", second: "170", last: "")
                    TemperatureLine(first: "350", second: "180", last: "Medium")
                    TemperatureLine(first: "375", second: "190", last: "")
                    TemperatureLine(first: "400", second: "200", last: "Moderate")
                    
                }
                Group {
                    TemperatureLine(first: "425", second: "220", last: "")
                    TemperatureLine(first: "450", second: "230", last: "Hot")
                    TemperatureLine(first: "475", second: "240", last: "Very Hot")
                    
                }
                
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
    }
}

struct ReferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceView()
    }
}

struct TemperatureLine: View {
    var first: String
    var second: String
    var last: String
    
    var body: some View {
        HStack {
            HStack(spacing: 60.0) {
                Text(first)
                Text(second)
            }
            
            Spacer()
            
            Text(last)
        }
    }
}
