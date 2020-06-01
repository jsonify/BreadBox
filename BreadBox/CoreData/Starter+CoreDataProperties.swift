//
//  Starter+CoreDataProperties.swift
//  BreadBox
//
//  Created by Jason Rueckert on 5/30/20.
//  Copyright © 2020 Jason Rueckert. All rights reserved.
//
//

import Foundation
import CoreData


extension Starter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Starter> {
        return NSFetchRequest<Starter>(entityName: "Starter")
    }

    @NSManaged public var name: String
    @NSManaged public var waterAmount: Double
    @NSManaged public var flourAmount: Double
    @NSManaged public var seedAmount: Double
    @NSManaged public var id: UUID?
    @NSManaged public var instructions: String
    
//    var wrappedName: String {
//        get {
//            name = self.wrappedName
//        }
//    }

}
