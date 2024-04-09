//
//  EditingDetailCard.swift
//  CRUD Template
//
//  Created by Mark Descalzo on 4/9/24.
//

import SwiftUI

struct EditingDetailCard: View {
  @Binding var title: String
  @Binding var descriptionText: String
  @Binding var completed: Bool
  @Binding var priority: Int16
  @Binding var timestamp: Date
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      TextField("Title", text: $title)
        .font(.title)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity, alignment: .leading)

      TextField("Description", text: $descriptionText)
        .font(.body)
        .lineLimit(0)
        .frame(maxWidth: .infinity, alignment: .leading)

      Toggle(isOn: $completed) {
        Text("Completed")
      }
      .font(.callout)
      
      Stepper("Priority: \(priority)", value: $priority, in: 1...5)
        .font(.callout)
      
      Text("Created on \(timestamp, formatter: itemFormatter)")
        .font(.footnote)
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity) // Make the card expand to fit its parent
    .background(Color.white)
    .cornerRadius(8.0)
    .shadow(color: .gray, radius: 6)
  }
  
  let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
  }()
}

#Preview {
  EditingDetailCard(title: .constant("Sample Title"),
                    descriptionText: .constant("This is a sample description text for our item."),
                    completed: .constant(true),
                    priority: .constant(3),
                    timestamp: .constant(Date()))
  .padding()
  .previewLayout(.sizeThatFits) // Optionally adjust the preview layout
}
