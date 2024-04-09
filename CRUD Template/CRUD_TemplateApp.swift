//
//  CRUD_TemplateApp.swift
//  CRUD Template
//
//  Created by Mark Descalzo on 4/8/24.
//

import SwiftUI

@main
struct CRUD_TemplateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
