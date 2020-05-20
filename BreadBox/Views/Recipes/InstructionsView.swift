//
//  InstructionsView.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/19/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//

import CoreData
import SwiftUI

struct InstructionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    var recipe: Recipe
    
    var body: some View {
        Text("\(self.recipe.instructions ?? "")")
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        
        let recipe = Recipe(context: moc)
        recipe.instructions = "These are the instructions"
        
        return NavigationView {
           InstructionsView(recipe: recipe)
        }
        
    }
}
