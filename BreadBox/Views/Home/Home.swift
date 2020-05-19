//
//  Home.swift
//  Breader
//
//  Created by Jason Rueckert on 5/16/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import SwiftUI

struct Home: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(fetchRequest: Recipe.allRecipesFetchRequest()) var recipes: FetchedResults<Recipe>
//
    @State private var showingAddScreen = false
    
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
                
//                Text("Hello")
                ScrollView {
                    ForEach(0..<5) {_ in 
//                    ForEach(self.recipes, id: \.self) { recipe in
                        Button(action: {
                            self.showingAddScreen.toggle()
                        }) {
                            RecipeView()
//                            Text("Hi there")
                        }
                        .padding(.top)
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

let screen = UIScreen.main.bounds
