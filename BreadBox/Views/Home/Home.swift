//
//  Home.swift
//  Breader
//
//  Created by Jason Rueckert on 5/16/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

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
                .padding(.top, 30)
                
                ScrollView {
                                        ForEach(0..<5) { number in
//                    ForEach(self.recipes, id: \.self) { recipe in
                        Button(action: {
                            self.showRecipeView.toggle()
                            self.recipeNumber = number
                        }) {
                            RecipeViewCell(number: number)
                        }
                        .foregroundColor(.black)
                        .padding(.top)
                    }
                }
                
                Spacer()
            }
            .statusBar(hidden: true)
            
            RecipeView(showRecipeView: $showRecipeView, number: $recipeNumber)
                .offset(y: self.showRecipeView ? 0 : 900)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct RecipeViewCell: View {
//    var recipe: Recipe
    var number: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("sourdough \(number)".uppercased())
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
