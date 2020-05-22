//
//  AddRecipeView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/18/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import CoreData
import SwiftUI

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) var moc
     @Environment(\.presentationMode) var presentationMode
     
     @State private var recipeName = ""
     @State private var flourAmount = ""
     @State private var waterAmount = ""
     @State private var starterAmount = ""
     @State private var saltAmount = ""
     @State private var yeastAmount = ""
     @State private var hyd = 0.0
     @State private var textBox = ""
     
     var mulitLineText: String {
         return String(textBox)
     }
     
     var hydration: Double {
         let formatter = NumberFormatter()
         formatter.locale = Locale.current // USA: Locale(identifier: "en_US")
         formatter.numberStyle = .decimal
         let f = formatter.number(from: flourAmount) as? Double ?? 0
         let w = formatter.number(from: waterAmount) as? Double ?? 0
         let finalHydration = (w / f) * 100
         return finalHydration
     }
    
     
     var body: some View {
             ZStack {
                 
                 VStack {
                     VStack {
                         VStack {
                             HStack {
                                CustomTextField(placeHolder: "Recipe Name".uppercased(), value: $recipeName, lineColor: .secondary, width: 1)
                                .scaledFont(name: "Avenir", size: 12)
                                 
                                Text("Hydration: \(String(format: "%.0f", self.hydration ))%".uppercased())
                                    .scaledFont(name: "Avenir", size: 12)
                                     .foregroundColor((Int(self.flourAmount) ?? 0 > 1 && Int(self.waterAmount) ?? 0 > 1) ? .blue : .secondary)
                                     .padding(.leading, 35)
                             }
                             
                             HStack {
                                 CustomTextField(placeHolder: "Flour (g)".uppercased(), value: $flourAmount, lineColor: .secondary, width: 1)
                                .scaledFont(name: "Avenir", size: 12)
                                 
                                 CustomTextField(placeHolder: "Water (g)".uppercased(), value: $waterAmount, lineColor: .secondary, width: 1)
                                .scaledFont(name: "Avenir", size: 12)
                             }
                             .keyboardType(.decimalPad)
                             
                             HStack {
                                 CustomTextField(placeHolder: "Starter (g)".uppercased(), value: $starterAmount, lineColor: .secondary, width: 1)
                                .scaledFont(name: "Avenir", size: 12)
                                 
                                 CustomTextField(placeHolder: "Salt (g)".uppercased(), value: $saltAmount, lineColor: .secondary, width: 1)
                                .scaledFont(name: "Avenir", size: 12)
                                 
                                 CustomTextField(placeHolder: "Yeast (g)".uppercased(), value: $yeastAmount, lineColor: .secondary, width: 1)
                                .scaledFont(name: "Avenir", size: 12)
                             }
                             .keyboardType(.decimalPad)
                         }
                         .padding(.vertical, 20.0)
                         
                        Spacer()
                         VStack {
                            Text("Instructions".uppercased())
                                 .foregroundColor(.secondary)
                            .kerning(4)
                            .scaledFont(name: "Avenir", size: 16)
                            
                             TextView(text: $textBox)
                            .cornerRadius(5)
                            .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1))
                         }
                         
                         Button(action: {
                             self.PopulateCoreData()
                             self.ResetFields()
                             
                         }) {
                             HStack {
                                 Image(systemName: "plus")
                                     .foregroundColor(.white)
                                     .imageScale(.small)
                                 Text("Add Recipe".uppercased())
                                     .foregroundColor(.white)
                                .scaledFont(name: "Avenir", size: 12)
                             }
                             .frame(maxWidth: .infinity)
                             .frame(height: 30)
                             .background(self.recipeName.isEmpty ? Color.gray : Color.red)
                             .cornerRadius(5)
                         }
                         .disabled(self.recipeName.isEmpty ? true : false)
                         .padding()
                     }
                     .padding(.horizontal)
                     .padding(.top)
                     Spacer()
                 }
                 .padding(.top, 30.0)
             }
             .statusBar(hidden: true)
     }
     
        fileprivate func ResetFields() {
            self.recipeName = ""
            self.flourAmount = ""
            self.waterAmount = ""
            self.starterAmount = ""
            self.saltAmount = ""
            self.yeastAmount = ""
            self.hyd = 0.0
        }
     
         fileprivate func PopulateCoreData() {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let dateString = dateFormatter.string(from: date as Date)
            
            let recipe = Recipe(context: self.moc)
            recipe.name = self.recipeName
            recipe.flourAmount = self.flourAmount
            recipe.waterAmount = self.waterAmount
            recipe.starterAmount = self.starterAmount
            recipe.saltAmount = self.saltAmount
            recipe.yeastAmount = self.yeastAmount
             recipe.instructions = self.textBox
            recipe.createdDateString = dateString
            self.hyd = self.hydration
            
            do {
                try self.moc.save()
                self.hyd = 0
             self.presentationMode.wrappedValue.dismiss()
            } catch {
                print(error)
            }
        }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
