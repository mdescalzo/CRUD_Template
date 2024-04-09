//
//  ListRow.swift
//  CRUD Template
//
//  Created by Mark Descalzo on 4/9/24.
//

import SwiftUI

struct ListRow: View {
  
  var title: String
  var completed: Bool
  var priority: Int16
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(title)
          .font(.headline)
        Text("Priority: \(priority)")
          .font(.subheadline)
        Text("Completed: \(completed ? "Yes" : "No")")
          .font(.footnote)
          .foregroundColor(completed ? .green : .red)
      }
//      .padding()
      Spacer()
    }
    .frame(maxWidth: .infinity)
  }
}

#Preview {
  ListRow(title: "Do the thing", completed: false, priority: 2)
    .previewLayout(.sizeThatFits)
    .background(Color.gray)
    .padding()
}
