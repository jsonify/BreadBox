//
//  Recipe+CoreDataClass.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/18/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Recipe)
public class Recipe: NSManagedObject, Identifiable {
    @NSManaged public var flourAmount: String
    @NSManaged public var id: UUID?
    @NSManaged public var name: String
    @NSManaged public var saltAmount: String
    @NSManaged public var starterAmount: String
    @NSManaged public var waterAmount: String
    @NSManaged public var yeastAmount: String
    @NSManaged public var instructions: String
    @NSManaged public var createdDateString: String
    
    @NSManaged public var starterName: String
    @NSManaged public var starterFlourAmount: String
    @NSManaged public var starterSeedAmount: String
    @NSManaged public var starterWaterAmount: String
    
//    unused
    @NSManaged public var updatedDateString: String
    @NSManaged public var notes: String
}
