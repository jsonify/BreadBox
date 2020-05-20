//
//  RecipeView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/18/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import CoreData
import SwiftUI

struct RecipeView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var show = false
    @State private var viewShowing = true
    @State private var showInstructionsView = false
    var recipe: Recipe
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Formula".uppercased())
                    .foregroundColor(.primary)
                    .font(.title).bold()
                    .kerning(3)
                    .bold()
                    .scaledFont(name: "Avenir", size: 28)
                
                Text("Flour: \(self.recipe.flourAmount ?? "0")g".uppercased())
                    .foregroundColor(.primary)
                    .kerning(2)
                    .scaledFont(name: "Avenir", size: 12)
                Text("Water: \(self.recipe.waterAmount ?? "0")g".uppercased())
                    .foregroundColor(.primary)
                    .kerning(2)
                    .scaledFont(name: "Avenir", size: 12)
                Text("Starter: \(self.recipe.starterAmount ?? "0")g".uppercased())
                    .kerning(2)
                    .scaledFont(name: "Avenir", size: 12)
                Text("Salt: \(self.recipe.saltAmount ?? "0")g".uppercased())
                    .kerning(2)
                    .scaledFont(name: "Avenir", size: 12)
            }
            .padding(30)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .offset(y: 300)
//            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .opacity(1)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(self.recipe.name ?? "")".uppercased())
                                .foregroundColor(.black)
                                .bold()
                                .kerning(3)
                                .scaledFont(name: "Avenir", size: 18)
                            
                            Spacer()
                            
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 23))
                                .foregroundColor(.white)
                                .offset(y: -40)
                                .onTapGesture {
                                    self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                        
                        Text("May 19, 2020".uppercased())
                            .kerning(2)
                            .foregroundColor(.white)
                            .scaledFont(name: "Avenir", size: 12)
                        Spacer()
                    }
                    .padding(.top, 60)
                    
                    Spacer()
                    
                    
                }
                
            }
            .padding(20)
            .frame(maxWidth:.infinity)
            .frame(maxHeight:300)
            .background(Color.gray)
            .cornerRadius(14)
             
            HStack {
                Image("icon-cookbook")
                    .onTapGesture {
                        self.showInstructionsView.toggle()
                }
            }
            .offset(y: screen.height - 160)
            .sheet(isPresented: $showInstructionsView) {
                InstructionsView(recipe: self.recipe).environment(\.managedObjectContext, self.moc)
            }
        }
        .statusBar(hidden: true)
        .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
    }
    
    
}

struct RecipeView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let recipe = Recipe(context: moc)
        recipe.name = "Sourdoh!"
        recipe.flourAmount = "505"
        recipe.waterAmount = "130"
        recipe.starterAmount = "125"
        recipe.saltAmount = "10"
        
        return NavigationView {
            RecipeView(recipe: recipe)
        }
    }
}
