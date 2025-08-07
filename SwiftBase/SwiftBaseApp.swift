//
//  SwiftBaseApp.swift
//  SwiftBase
//
//  Created by Cookie-san on 2025/08/07.
//

import SwiftUI

@main
struct SwiftBaseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
