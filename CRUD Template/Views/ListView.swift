//
//  MenuView.swift
//  CRUD Template
//
//  Created by Mark Descalzo on 4/8/24.
//

import SwiftUI
import CoreData

struct ListView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default)
  
  private var items: FetchedResults<Item>
  
  @State private var showingAddItemView = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(items, id: \.self) { item in
          let itemModel = ItemViewModel(item: item, context: viewContext)
          
          NavigationLink(destination: DetailView(viewModel: itemModel)) {
            ListRow(title: itemModel.title, completed: itemModel.completed, priority: itemModel.priority)
          }
        }
        .onDelete(perform: deleteItems)
      }
      .navigationTitle("To-do List")h
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
    }
    .sheet(isPresented: $showingAddItemView) {
      AddItemModalView(isPresented: $showingAddItemView)
    }
  }
  
  private func addItem() {
    withAnimation {
      showingAddItemView = true
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)
      
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
  
  private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
  }()
}

#Preview {
  ListView()
}
