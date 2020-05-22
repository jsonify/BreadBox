//
//  AddInstructionsView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/21/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct AddInstructionsView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var textBox = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 30.0) {
                HStack {
                    Text("Process".uppercased())
                        .font(AvFont.header)
                        .tracking(3)
                        .bold()
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cancel".uppercased())
                                .font(AvFont.subtitle)
                                .tracking(1)
                                .frame(width: 60, height: 25)
                                .background(Color("buttonGray"))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                        
                        Button(action: {
                            self.populateCoreData()
                            self.resetFields()
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save".uppercased())
                                .tracking(1)
                                .font(AvFont.subtitle)
                                .frame(width: 60, height: 25)
                                .background(Color(#colorLiteral(red: 0.3176470588, green: 0.5882352941, blue: 0.8352941176, alpha: 1)))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                
                        }
                    }
                }
                    

                HStack {
                    Text("Instructions:".uppercased())
                        .font(AvFont.title)
                        .bold()
                        .tracking(0.5)
                    
                    Spacer()
                }
                
                TextView(text: $textBox)
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
            }
            .padding(.horizontal, 30)
            .offset(y: -100)
        }
    }
    
    fileprivate func resetFields() {
               // ℹ️ Reset the temporary in-memory storage variables for the next new recipe!]
               self.textBox = ""
           }
        
            fileprivate func populateCoreData() {
               let recipe = Recipe(context: self.moc)
                recipe.instructions = self.textBox
               
               do {
                   try self.moc.save()
                self.presentationMode.wrappedValue.dismiss()
               } catch {
                   print(error)
               }
           }
}

struct AddInstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        AddInstructionsView()
    }
}

