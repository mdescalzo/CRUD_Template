//
//  ItemViewModel.swift
//  CRUD Template
//
//  Created by Mark Descalzo on 4/9/24.
//

import Foundation
import CoreData

class ItemViewModel: ObservableObject {
  private var item: Item
  private var viewContext: NSManagedObjectContext
  
  @Published var title: String = ""
  @Published var descriptionText: String = ""
  @Published var completed: Bool = false
  @Published var priority: Int = 0
  @Published var timestamp: Date = Date()
  
  init(item: Item, context: NSManagedObjectContext) {
    self.item = item
    self.viewContext = context
    
    loadItemData()
  }
  
  func discardChanges() {
    loadItemData()
  }
  
  func discardSelf() {
    self.viewContext.delete(self.item)
  }
  
  private func loadItemData() {
    title = item.title ?? ""
    descriptionText = item.descriptionText ?? ""
    completed = item.completed
    priority = Int(item.priority)
    if let ts = item.timestamp {
      timestamp = ts
    }
  }
  
  func saveChanges() {
    item.title = self.title
    item.descriptionText = self.descriptionText
    item.completed = self.completed
    item.priority = Int64(self.priority)
    item.timestamp = self.timestamp
    
    do {
      try viewContext.save()
    } catch {
      print("Failed to save item: \(error.localizedDescription)")
    }
  }
}
