//
//  RootView.swift
//  CRUD Template
//
//  Created by Mark Descalzo on 4/8/24.
//

import SwiftUI
import CoreData

struct RootView: View {
    var body: some View {
      NavigationView {
        ListView()
      }
    }
}

#Preview {
  RootView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
