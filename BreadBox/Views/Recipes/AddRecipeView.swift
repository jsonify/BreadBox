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
                 Color(#colorLiteral(red: 1, green: 0.9740341306, blue: 0.7952792645, alpha: 1))
                     .edgesIgnoringSafeArea(.all)
                 VStack {
                     VStack {
                         VStack {
                             HStack {
                                 CustomTextField(placeHolder: "Recipe Name", value: $recipeName, lineColor: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), width: 1)
                                 
                                 Text("Hydration: \(String(format: "%.0f", self.hydration ))%")
                                     .foregroundColor((Int(self.flourAmount) ?? 0 > 1 && Int(self.waterAmount) ?? 0 > 1) ? .blue : Color(#colorLiteral(red: 1, green: 0.9740341306, blue: 0.7952792645, alpha: 1)))
                                     .padding(.leading, 35)
                             }
                             
                             HStack {
                                 CustomTextField(placeHolder: "Flour (g)", value: $flourAmount, lineColor: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), width: 1)
                                 
                                 CustomTextField(placeHolder: "Water (g)", value: $waterAmount, lineColor: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), width: 1)
                             }
                             .keyboardType(.decimalPad)
                             
                             HStack {
                                 CustomTextField(placeHolder: "Starter (g)", value: $starterAmount, lineColor: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), width: 1)
                                 
                                 CustomTextField(placeHolder: "Salt (g)", value: $saltAmount, lineColor: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), width: 1)
                                 
                                 CustomTextField(placeHolder: "Yeast (g)", value: $yeastAmount, lineColor: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), width: 1)
                             }
                             .keyboardType(.decimalPad)
                         }
                         .padding(.vertical, 20.0)
                         
                         VStack {
                             Text("Instructions")
                                 .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                             TextView(text: $textBox)
                         }
                         
                         Button(action: {
                             self.PopulateCoreData()
                             self.ResetFields()
                             
                         }) {
                             HStack {
                                 Image(systemName: "plus")
                                     .foregroundColor(.white)
                                     .imageScale(.small)
                                 Text("Add Recipe")
                                     .foregroundColor(.white)
                             }
                             .frame(maxWidth: .infinity)
                             .frame(height: 30)
                             .background(self.recipeName.isEmpty ? Color.gray : Color.green)
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
            let recipe = Recipe(context: self.moc)
            recipe.name = self.recipeName
            recipe.flourAmount = self.flourAmount
            recipe.waterAmount = self.waterAmount
            recipe.starterAmount = self.starterAmount
            recipe.saltAmount = self.saltAmount
            recipe.yeastAmount = self.yeastAmount
             recipe.instructions = self.textBox
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
