//
//  DetailView.swift
//  CRUD Template
//
//  Created by Mark Descalzo on 4/8/24.
//

import SwiftUI

struct DetailView: View {
  @ObservedObject var viewModel: ItemViewModel
    
  @State private var isEditing = false
  
  var body: some View {
    ScrollView {
      ZStack {
        if isEditing {
          EditingDetailCard(
            title: $viewModel.title,
            descriptionText: $viewModel.descriptionText,
            completed: $viewModel.completed,
            priority: $viewModel.priority,
            timestamp: $viewModel.timestamp
          )
          .transition(.opacity)
        } else {
          DetailCard(
            title: $viewModel.title,
            descriptionText: $viewModel.descriptionText,
            completed: $viewModel.completed,
            priority: $viewModel.priority,
            timestamp: $viewModel.timestamp
          )
          .transition(.opacity)
        }
      }
      .animation(.default, value: isEditing)
      .padding()
    }
    .padding()
    .navigationBarItems(trailing: HStack {
      if isEditing {
        Button("Cancel") {
          // Discard changes and exit edit mode
          resetToOriginalValues()
          isEditing = false
        }
      }
      Button(isEditing ? "Save" : "Edit") {
        withAnimation {
          if isEditing {
            // Save the changes
            viewModel.saveChanges()
            isEditing = false
          } else {
            // Enter edit mode
            isEditing = true
          }
        }
      }
    })
  }
  
  private func resetToOriginalValues() {
    viewModel.discardChanges()
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

#Preview {
  // Use the preview context to create a sample Item
  let context = PersistenceController.preview.container.viewContext
  let sampleItem = Item.previewItem(managedObjectContext: context)
  
  return DetailView(viewModel: ItemViewModel(item: sampleItem, context: context))
}
