//
//  DetailCard.swift
//  CRUD Template
//
//  Created by Mark Descalzo on 4/9/24.
//

import SwiftUI

struct DetailCard: View {
  @Binding var title: String
  @Binding var descriptionText: String
  @Binding var completed: Bool
  @Binding var priority: Int
  @Binding var timestamp: Date
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(title)
        .font(.title)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      Text(descriptionText)
        .font(.body)
        .frame(maxWidth: .infinity, alignment: .leading)

      Text("Completed: \(completed ? "Yes" : "No")")
        .font(.callout)
        .foregroundColor(completed ? .green : .red)
        .frame(maxWidth: .infinity, alignment: .leading)

      Text("Priority: \(priority)")
        .font(.callout)
        .frame(maxWidth: .infinity, alignment: .leading)

      Text("Created on \(timestamp, formatter: itemFormatter)")
        .font(.footnote)
        .frame(maxWidth: .infinity, alignment: .leading)
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
  DetailCard(title: .constant("Sample Title"),
             descriptionText: .constant("This is a sample description text for our item."),
             completed: .constant(true),
             priority: .constant(3),
             timestamp: .constant(Date()))
  .padding()
  .previewLayout(.sizeThatFits) // Optionally adjust the preview layout
}
