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
    @State private var showingSheet = false
    
    var recipe: Recipe
    
    @State private var updatedFlourAmount: String = ""
    @State private var updatedWaterAmount: String = ""
    @State private var updatedStarterAmount: String = ""
    @State private var updatedSaltAmount: String = ""
    @State private var updatedYeastAmount: String = ""
    @State private var updatedAdditionalIngredients = ""
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
                            Haptic().simpleSuccess()
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Close".uppercased())
                                .font(AvFont.subtitle)
                                .tracking(1)
                                .frame(width: 60, height: 25)
                                .background(Color("Crumb"))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                        
                        Button(action: {
                            Haptic().simpleSuccess()
                            self.updateCoreData()
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("update".uppercased())
                                .tracking(1)
                                .font(AvFont.subtitle)
                                .frame(width: 60, height: 25)
                                .background(Color("Crust"))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                            
                        }
                    }
                }
                .padding(.horizontal, 30)
                
                VStack {
                    HStack {
                        Text("Recipe Name:".uppercased())
                            .font(AvFont.title)
                            .bold()
                            .tracking(0.5)
                        
                        Spacer()
                        
                        Button(action: {
                            self.shareButton()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(Color("Crust"))
                        }
                        .padding(.trailing, 30)
                    }
                    
                    HStack {
                        Text("\(self.recipe.name)")
                
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
                        Text("Additional Ingredients:".uppercased())
                            .font(AvFont.title)
                            .bold()
                            .tracking(0.5)
                        
                        Spacer()
                    }
                    TextView(text: $updatedAdditionalIngredients)
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .cornerRadius(10)
                        .foregroundColor(Color("textField"))
                        .onAppear {
                                self.updatedAdditionalIngredients = self.recipe.additionalIngredients
                        }
                        .padding(.bottom, 30)
                    
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
    
    func shareButton() {
        showingSheet.toggle()
        
        let updatedRecipe = "Here's that recipe:\n\(self.recipe.name)\n\nFlour: \(self.updatedFlourAmount)g\nWater: \(self.updatedWaterAmount)g\nStarter: \(self.updatedStarterAmount)g\nSalt: \(self.updatedSaltAmount)g\nYeast: \(self.updatedYeastAmount)g\nAdditional Ingredients:\n \(self.updatedAdditionalIngredients)\n\nInstructions:\n\(self.updatedInstructions)"
        let av = UIActivityViewController(activityItems: [updatedRecipe], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?
        .present(av, animated: true, completion: nil)
    }
    
    func updateCoreData() {
        self.recipe.flourAmount = self.updatedFlourAmount
        self.recipe.waterAmount = self.updatedWaterAmount
        self.recipe.starterAmount = self.updatedStarterAmount
        self.recipe.saltAmount = self.updatedSaltAmount
        self.recipe.yeastAmount = self.updatedYeastAmount
        self.recipe.additionalIngredients = self.updatedAdditionalIngredients
        self.recipe.instructions = self.updatedInstructions
        
        do {
            try self.moc.save()
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
