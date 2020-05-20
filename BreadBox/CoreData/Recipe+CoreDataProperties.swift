//
//  Recipe+CoreDataProperties.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/18/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//
//

import Foundation
import CoreData

extension Recipe {
    // ❇️ The @FetchRequest property wrapper in the ContentView will call this function
    static func allRecipesFetchRequest() -> NSFetchRequest<Recipe> {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest() as! NSFetchRequest<Recipe>
        
        // ❇️ The @FetchRequest property wrapper in the ContentView requires a sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
          
        return request
    }
}
