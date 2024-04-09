//
//  Item+CoreDataProperties.swift
//  CRUD Template
//
//  Created by Mark Descalzo on 4/8/24.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var timestamp: Date
    @NSManaged public var id: UUID
    @NSManaged public var title: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var completed: Bool
    @NSManaged public var priority: Int16

}

extension Item : Identifiable {

}
