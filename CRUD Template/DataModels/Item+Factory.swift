//
//  Item+Factory.swift
//  CRUD Template
//
//  Created by Mark Descalzo on 4/8/24.
//

import CoreData

extension Item {
  /// Creates a preview item for SwiftUI previews or testing.
  /// - Parameter managedObjectContext: The managed object context in which the item should be created.
  /// - Returns: A new `Item` instance with predefined attributes.
  static func previewItem(managedObjectContext: NSManagedObjectContext) -> Item {
    let item = Item(context: managedObjectContext)
    item.id = UUID()
    item.title = "Sample Task"
    item.descriptionText = "This is a detailed description of the task."
    item.completed = false
    item.priority = 1 // Highest priority
    item.timestamp = Date()
    return item
  }
  
  static func newItem(managedObjectContext: NSManagedObjectContext) -> Item {
    let item = Item(context: managedObjectContext)
    item.id = UUID()
    item.timestamp = Date()
    item.title = "New Item"
    item.descriptionText = "Description"
    item.completed = false
    item.priority = 1 // Default priority
    return item
  }
}
