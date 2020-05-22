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
    @State private var showingStarterFormulaView = false
    @State private var recipeNumber = 0
    //
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("Recipes".uppercased())
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
                    .padding(.horizontal, 30)
                    .padding(.top, 60)
                    
                    List {
                        ForEach(self.recipes, id: \.self) { recipe in
                            NavigationLink(destination:
                                DetailView(recipe: recipe)
                            ){
                                RecipeViewCell(recipe: recipe)
                            }
                            
                        }
                        .onDelete(perform: deleteRecipes)
                    }
                    .onAppear { UITableView.appearance().separatorStyle = .none }
                    
                    Spacer()
                    HStack {
                        Image("icon-gear")
                            .foregroundColor(Color("buttonGray"))
                            .onTapGesture {
                                self.showingSettingsScreen.toggle()
                        }
                        .sheet(isPresented: $showingSettingsScreen) {
                            SettingsView()
                        }
                        
                        Spacer()
                        Image("icon-plus")
                            .foregroundColor(Color("buttonGray"))
                            .onTapGesture {
                                self.showingAddScreen.toggle()
                        }
                        .sheet(isPresented: $showingAddScreen) {
                            CreateView().environment(\.managedObjectContext, self.moc)
                        }
                        
                        Spacer()
                        Image("icon-test-tube")
                            .foregroundColor(Color("buttonGray"))
                            .onTapGesture {
//                                self.showingStarterFormulaView.toggle()
                                NavigationLink(destination: StarterFormulaView()) {
                                    Text("Hello")
                                }
                        }
                        .sheet(isPresented: $showingStarterFormulaView) {
                            StarterFormulaView().environment(\.managedObjectContext, self.moc)
                        }
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
    
    func deleteRecipes(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let recipe = recipes[offset]
            
            // delete it from the context
            moc.delete(recipe)
        }
        
        // save the context
        try? moc.save()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return Home().environment(\.managedObjectContext, context)
    }
}



let screen = UIScreen.main.bounds
