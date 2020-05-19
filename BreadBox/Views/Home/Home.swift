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
    @State private var showingSettingsScreen = false
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
                            self.showingAddScreen.toggle()
                        }) {
                            Image("icon-filter")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 60)
                    
                    ScrollView {
                        ForEach(self.recipes, id: \.self) { recipe in
                            NavigationLink(destination: RecipeView(recipe: recipe)) {
                                RecipeViewCell(recipe: recipe)
                            }
                            
                        }
                    }
                    
                    Spacer()
                    HStack {
                        Image("icon-gear")
                            .onTapGesture {
                                self.showingSettingsScreen.toggle()
                        }
                        .sheet(isPresented: $showingSettingsScreen) {
                        SettingsView()
                        }
                        
                        Spacer()
                        Image("icon-plus")
                            .onTapGesture {
                                self.showingAddScreen.toggle()
                        }
                        .sheet(isPresented: $showingAddScreen) {
                            AddRecipeView().environment(\.managedObjectContext, self.moc)
                        }
                        
                        Spacer()
                        Image("icon-graph")
                    }
                    .padding(.bottom, 40)
                    .padding(.horizontal, 40)
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle(Text(""))
                
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



let screen = UIScreen.main.bounds
