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

//@objc(Recipe)
//public class Recipe: NSManagedObject, Identifiable {
//    @NSManaged public var flourAmount: String?
//    @NSManaged public var id: UUID?
//    @NSManaged public var name: String?
//    @NSManaged public var saltAmount: String?
//    @NSManaged public var starterAmount: String?
//    @NSManaged public var water: Float
//    @NSManaged public var waterAmount: String?
//    @NSManaged public var yeastAmount: String?
//    @NSManaged public var instructions: String?
//    @NSManaged public var notes: String?
//}

//extension Recipe {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
//        return NSFetchRequest<Recipe>(entityName: "Recipe")
//    }
//
//    @NSManaged public var id: UUID?
//    @NSManaged public var flourAmount: String?
//    @NSManaged public var instructions: String?
//    @NSManaged public var name: String?
//    @NSManaged public var saltAmount: String?
//    @NSManaged public var waterAmount: String?
//    @NSManaged public var yeastAmount: String?
//    @NSManaged public var starterAmount: String?
//
//}

extension Recipe {
    // ❇️ The @FetchRequest property wrapper in the ContentView will call this function
    static func allRecipesFetchRequest() -> NSFetchRequest<Recipe> {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest() as! NSFetchRequest<Recipe>
        
        // ❇️ The @FetchRequest property wrapper in the ContentView requires a sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
          
        return request
    }
}
