//
//  DetailView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/22/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var recipe: Recipe
    
//    @State private var updatedRecipeName: String = ""
    @State private var updatedFlourAmount: String = ""
    @State private var updatedWaterAmount: String = ""
    @State private var updatedStarterAmount: String = ""
    @State private var updatedSaltAmount: String = ""
    @State private var updatedYeastAmount: String = ""
    @State private var updatedInstructions: String = ""
    
    //    var hydration: Double {
    //        let formatter = NumberFormatter()
    //        formatter.locale = Locale.current
    //        formatter.numberStyle = .decimal
    //        let f = formatter.number(from: flourAmount) as? Double ?? 0
    //        let w = formatter.number(from: waterAmount) as? Double ?? 0
    //        let finalHydration = (w / f) * 100
    //        return finalHydration
    //    }
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 30.0) {
                HStack {
                    Text("Make this".uppercased())
                        .font(AvFont.header)
                        .tracking(3)
                        .bold()
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
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
                        
                        Button(action: {
                            self.updateCoreData()
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("update".uppercased())
                                .tracking(1)
                                .font(AvFont.subtitle)
                                .frame(width: 60, height: 25)
                                .background(Color(#colorLiteral(red: 0.3176470588, green: 0.5882352941, blue: 0.8352941176, alpha: 1)))
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
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("\(self.recipe.name)")
//                        TextField("", text: $updatedRecipeName)
//                            .padding(8)
//                            .background(RoundedRectangle(cornerRadius: 10)
//                                .foregroundColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1))))
//                            .foregroundColor(Color("textField"))
//                            .frame(width: 255, height: 39)
//                            .onAppear {
//                                self.updatedRecipeName = self.recipe.name
//                        }
                        
                        Spacer()
                        
                    }
                    
                }
                .padding(.leading, 30)
                
                Ingredient(type: "flour", typeAmount: $updatedFlourAmount)
                    .onAppear {
                        self.updatedFlourAmount = self.recipe.flourAmount
                }
                Ingredient(type: "water", typeAmount: $updatedWaterAmount)
                    .onAppear {
                        self.updatedWaterAmount = self.recipe.waterAmount
                }
                Ingredient(type: "starter", typeAmount: $updatedStarterAmount)
                    .onAppear {
                        self.updatedStarterAmount = self.recipe.starterAmount
                }
                Ingredient(type: "salt", typeAmount: $updatedSaltAmount)
                    .onAppear {
                        self.updatedSaltAmount = self.recipe.saltAmount
                }
                Ingredient(type: "yeast", typeAmount: $updatedYeastAmount)
                    .onAppear {
                        self.updatedYeastAmount = self.recipe.yeastAmount
                }
                
                VStack {
                    HStack {
                        Text("Instructions:".uppercased())
                            .font(AvFont.title)
                            .bold()
                            .tracking(0.5)
                        
                        Spacer()
                    }
                    TextView(text: $updatedInstructions)
                        
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .cornerRadius(10)
                        .foregroundColor(Color("textField"))
                        .onAppear {
                            self.updatedInstructions = self.recipe.instructions
                    }
                }
                .padding(.horizontal, 30)
                
                
            }
        }
        .statusBar(hidden: true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
    }
    
    func updateCoreData() {
//        self.recipe.name = self.updatedRecipeName
        self.recipe.flourAmount = self.updatedFlourAmount
        self.recipe.waterAmount = self.updatedWaterAmount
        self.recipe.starterAmount = self.updatedStarterAmount
        self.recipe.saltAmount = self.updatedSaltAmount
        self.recipe.yeastAmount = self.updatedYeastAmount
        self.recipe.instructions = self.updatedInstructions
        
        do {
            try self.moc.save()
        } catch {
            print(error)
        }
    }
    
    fileprivate func populateCoreData() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: date as Date)
        
        let recipe = Recipe(context: self.moc)
//        recipe.name = self.updatedRecipeName
        recipe.flourAmount = self.updatedFlourAmount
        recipe.waterAmount = self.updatedWaterAmount
        recipe.starterAmount = self.updatedStarterAmount
        recipe.saltAmount = self.updatedSaltAmount
        recipe.yeastAmount = self.updatedYeastAmount
        recipe.instructions = self.updatedInstructions
        //        recipe.dateString = dateString
        //        self.hyd = self.hydration
        
        do {
            try self.moc.save()
            //            self.hyd = 0
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            print(error)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let recipe = Recipe(context: moc)
        recipe.name = "Sourdoh!"
        recipe.flourAmount = "505"
        recipe.waterAmount = "130"
        recipe.starterAmount = "125"
        recipe.saltAmount = "10"
        recipe.yeastAmount = "1"
        recipe.instructions = "These are the instructions to use"
        
        return NavigationView {
            DetailView(recipe: recipe)
        }
    }
}
