//
//  Home.swift
//  Breader
//
//  Created by Jason Rueckert on 5/16/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import CoreData
import SwiftUI

struct Home: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Recipe.allRecipesFetchRequest()) var recipes: FetchedResults<Recipe>
    //
    @State private var showingAddScreen = false
    @State private var showRecipeView = false
    @State private var recipeNumber = 0
//
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("RECIPES")
                            .kerning(6)
                            .bold()
                            .scaledFont(name: "Avenir", size: 28)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Image("icon-filter")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 60)
                    
                    ScrollView {
//                                            ForEach(0..<5) { number in
                        ForEach(self.recipes, id: \.self) { recipe in
                            NavigationLink(destination: RecipeView(recipe: recipe)) {
                                RecipeViewCell(recipe: recipe)
                            }
//                            Button(action: {
//                                self.showRecipeView.toggle()
//                                self.recipeNumber = number
//                            }) {
//                                RecipeViewCell(number: number)
//                            }
//                            .foregroundColor(.black)
//                            .padding(.top)
                        }
                    }
                    
                    Spacer()
                }
                
//                RecipeView(showRecipeView: $showRecipeView, number: $recipeNumber)
//                    .offset(y: self.showRecipeView ? 30 : 900)
            }
            .navigationBarHidden(true)
            .navigationBarTitle(Text("Home"))
            .edgesIgnoringSafeArea([.top, .bottom])
        }
        .statusBar(hidden: true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return Home().environment(\.managedObjectContext, context)
    }
}

struct RecipeViewCell: View {
    var recipe: Recipe
//    var number: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(self.recipe.name ?? "")".uppercased())
                    .bold()
                    .kerning(3)
                    .scaledFont(name: "Avenir", size: 18)
                
                Spacer()
            }
            
            Text("May 19, 2020".uppercased())
                .kerning(2)
                .foregroundColor(.white)
                .scaledFont(name: "Avenir", size: 12)
        }
        .padding(20)
        .frame(maxWidth:.infinity)
        .frame(maxHeight:300)
        .background(Color.gray)
        .cornerRadius(14)
        
        //        .onTapGesture {
        //            //            self.show.toggle()
        ////            print("button tapped")
        //        }
    }
}

let screen = UIScreen.main.bounds
