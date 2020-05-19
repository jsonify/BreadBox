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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var flourAmount: String?
    @NSManaged public var instructions: String?
    @NSManaged public var name: String?
    @NSManaged public var saltAmount: String?
    @NSManaged public var waterAmount: String?
    @NSManaged public var yeastAmount: String?
    @NSManaged public var starterAmount: String?

}
