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
    @State private var showingCreateView = false
    @State private var showingSettingsScreen = false
    @State private var showRecipeView = false
    @State private var showingStarterFormulaView = false
    @State private var showReferenceView = false
    
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
                        
                        
                            Image("icon-book")
                        .resizable()
                        .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("Crust"))
                        .onTapGesture {
                                self.showReferenceView.toggle()
                                Haptic().simpleSuccess()
                        }
                        .sheet(isPresented: $showReferenceView) {
                            ReferenceView()
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
                    //                    BottomBar(showingCreateView: $showingCreateView)
                    //                    .background(CurvedShape())
                    HStack {
                        Image("icon-gear")
                            .foregroundColor(Color("buttonGray"))
                            .onTapGesture {
                                self.showingSettingsScreen.toggle()
                        }
                            
                        .sheet(isPresented: $showingSettingsScreen) {
                            SettingsView()
                        }
                        .opacity(0)
                        
                        Spacer()
                        Image("icon-plus")
                            .foregroundColor(Color("Crust"))
                            .onTapGesture {
                                self.showingCreateView.toggle()
                                Haptic().simpleSuccess()
                        }
                        .sheet(isPresented: $showingCreateView) {
                            CreateView().environment(\.managedObjectContext, self.moc)
                        }
                        
                        Spacer()
                        Image("icon-test-tube")
                            .foregroundColor(Color("buttonGray"))
                            //                            .onTapGesture {
                            //                                self.showingStarterFormulaView.toggle()
                            //                                NavigationLink(destination: StarterFormulaView()) {
                            //                                    Text("Hello")
                            //                                }
                            //                        }
                            .opacity(0)
                            .sheet(isPresented: $showingStarterFormulaView) {
                                StarterFormulaView().environment(\.managedObjectContext, self.moc)
                        }
                    }
                    .padding(.bottom, 40)
                    .padding(.horizontal, 40)
                }
                //                ReferenceView()
                
            }
            .navigationBarHidden(true)
            .navigationBarTitle(Text(""))
            .edgesIgnoringSafeArea([.top, .bottom])
        }
        .statusBar(hidden: true)
    }
    
    func deleteRecipes(at offsets: IndexSet) {
        Haptic().simpleWarning()
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
