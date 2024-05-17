//
//  ModalView.swift
//  CRUD Template
//
//  Created by Mark Descalzo on 4/9/24.
//

import SwiftUI
import CoreData

struct AddItemModalView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @Binding var isPresented: Bool
  
  @State var title: String = ""
  @State var descriptionText: String = ""
  @State var completed: Bool = false
  @State var priority: Int = 3
  @State var timestamp: Date = Date()
  
  var body: some View {
    ScrollView {
      ZStack {
        VStack {
          EditingDetailCard(
            title: $title,
            descriptionText: $descriptionText,
            completed: $completed,
            priority: $priority,
            timestamp: $timestamp
          )
          Button("Save") {
            saveItem()
          }
          .padding()
          Button("Cancel") {
            cancel()
          }
          .padding()
        }
      }
      .padding()
    }
    .padding()
  }
  
  func saveItem() {
    let newItem = Item.newItem(managedObjectContext: viewContext)
    newItem.title = self.title
    newItem.descriptionText = self.descriptionText
    newItem.priority = Int64(self.priority)
    newItem.completed = self.completed
    newItem.timestamp = self.timestamp
    
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    
    isPresented = false
  }
  
  func cancel() {
    isPresented = false
  }
  
}

#Preview {
  AddItemModalView(isPresented: .constant(true))
}
