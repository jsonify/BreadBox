//
//  StarterCreateView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/30/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct StarterCreateView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var starterName = ""
    
    var body: some View {
        
        
        VStack {
            HStack {
                Text("Create".uppercased())
                    .font(AvFont.header)
                    .tracking(3)
                    .bold()
                
                Spacer()
                
                HStack {
                    Button(action: {
                        Haptic().simpleSuccess()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel".uppercased())
                            .font(AvFont.subtitle)
                            .tracking(1)
                            .frame(width: 60, height: 25)
                            .background(Color("Crumb"))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                    
                    Button(action: {
                        Haptic().simpleSuccess()
                        self.populateCoreData()
                        //                            self.resetFields()
                    }) {
                        Text("Save".uppercased())
                            .tracking(1)
                            .font(AvFont.subtitle)
                            .frame(width: 60, height: 25)
                            .background(self.starterName.isEmpty ? Color("buttonGray") : Color("Crust"))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                        
                    }
                }
            }
            .padding(.horizontal, 30)
            
            VStack {
                HStack {
                    Text("Name your starter:".uppercased())
                        .font(AvFont.title)
                        .bold()
                        .tracking(0.5)
                        .disableAutocorrection(true)
                    
                    Spacer()
                }
                
                HStack {
                    TextField("", text: $starterName)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1))))
                        .foregroundColor(Color("textField"))
                        .frame(width: 255, height: 39)
                    
                    Spacer()
                    
                }
                
            }
            .padding(.leading, 30)
        }
    }
    
    fileprivate func populateCoreData() {
        
        let starter = Starter(context: self.moc)
        starter.name = self.starterName
        
        do {
            try self.moc.save()
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            print(error)
        }
    }
}

struct StarterCreateView_Previews: PreviewProvider {
    static var previews: some View {
        StarterCreateView()
    }
}
