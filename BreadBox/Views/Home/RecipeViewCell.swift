//
//  RecipeViewCell.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/19/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import CoreData
import SwiftUI

struct RecipeViewCell: View {
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(self.recipe.name)".uppercased())
                    .bold()
                    .kerning(3)
                    .scaledFont(name: "Avenir", size: 18)
                    .foregroundColor(.black)
                
                Spacer()
            }
            
            Text("\(self.recipe.createdDateString)".uppercased())
                .kerning(2)
                .foregroundColor(Color("Crust"))
                .scaledFont(name: "Avenir", size: 10)
        }
        .padding(20)
        .frame(maxWidth:.infinity)
        .frame(maxHeight:70)
        .background(Color("Crumb"))
        .cornerRadius(14)
    .padding()
        
    }
}

struct RecipeViewCell_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let recipe = Recipe(context: moc)
        recipe.name = "Sourdoh!"
        recipe.flourAmount = "505"
        recipe.waterAmount = "130"
        recipe.starterAmount = "125"
        recipe.saltAmount = "10"
        
        return NavigationView {
            RecipeViewCell(recipe: recipe)
        }
    }
}
