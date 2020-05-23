//
//  CreateView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/20/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import CoreData
import SwiftUI

struct CreateView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showInstructions = false
    @State private var recipeName = ""
    @State private var flourAmount = ""
    @State private var waterAmount = ""
    @State private var starterAmount = ""
    @State private var saltAmount = ""
    @State private var yeastAmount = ""
    @State private var hyd = 0.0
    @State private var instructions = ""
    
    var mulitLineText: String {
        return String(instructions)
    }
    
    var hydration: Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        let f = formatter.number(from: flourAmount) as? Double ?? 0
        let w = formatter.number(from: waterAmount) as? Double ?? 0
        let finalHydration = (w / f) * 100
        return finalHydration
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30.0) {
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
                                .background(Color("buttonGray"))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                        
                        Button(action: {
                            Haptic().simpleSuccess()
                            self.populateCoreData()
                            self.resetFields()
                        }) {
                            Text("Save".uppercased())
                                .tracking(1)
                                .font(AvFont.subtitle)
                                .frame(width: 60, height: 25)
                                .background(self.recipeName.isEmpty ? Color("buttonGray") : Color(#colorLiteral(red: 0.3176470588, green: 0.5882352941, blue: 0.8352941176, alpha: 1)))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                            
                        }
                    }
                }
                .padding(.horizontal, 30)
                
                VStack {
                    HStack {
                        Text("Name your recipe:".uppercased())
                            .font(AvFont.title)
                            .bold()
                            .tracking(0.5)
                            .disableAutocorrection(true)
                        
                        Spacer()
                    }
                    
                    HStack {
                        TextField("", text: $recipeName)
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1))))
                            .foregroundColor(Color("textField"))
                            .frame(width: 255, height: 39)
                        
                        Spacer()
                        
                    }
                    
                }
                .padding(.leading, 30)
                
                Ingredient(type: "flour", typeAmount: $flourAmount)
                Ingredient(type: "water", typeAmount: $waterAmount)
                Ingredient(type: "starter", typeAmount: $starterAmount)
                Ingredient(type: "salt", typeAmount: $saltAmount)
                Ingredient(type: "yeast", typeAmount: $yeastAmount)
                
                VStack {
                    HStack {
                        Text("Instructions:".uppercased())
                            .font(AvFont.title)
                            .bold()
                            .tracking(0.5)
                        
                        Spacer()
                    }
                    TextView(text: $instructions)
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                    .cornerRadius(10)
                        .foregroundColor(Color("textField"))
                }
                .padding(.horizontal, 30)
                
                
            }
            .padding(.top, 30)
        }
        
    }
    fileprivate func resetFields() {
        self.recipeName = ""
        self.flourAmount = ""
        self.waterAmount = ""
        self.starterAmount = ""
        self.saltAmount = ""
        self.yeastAmount = ""
        self.hyd = 0.0
    }
    
    fileprivate func populateCoreData() {
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
        recipe.instructions = self.instructions
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

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}


