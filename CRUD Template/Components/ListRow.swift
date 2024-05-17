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
  var priority: Int
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(title)
          .font(.headline)
          .foregroundColor(AppTheme.textColor)
        Text("Priority: \(priority)")
          .font(.subheadline)
          .foregroundColor(AppTheme.textColor)
        Text("Completed: \(completed ? "Yes" : "No")")
          .font(.footnote)
          .foregroundColor(completed ? AppTheme.completeColor : AppTheme.incompleteColor)
      }
      Spacer()
    }
    .frame(maxWidth: .infinity)
  }
}

#Preview {
  ListRow(title: "Do the thing", completed: false, priority: 2)
    .previewLayout(.sizeThatFits)
    .border(Color.gray)
    .padding()
}
