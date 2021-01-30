//
//  SimpleBoxApp.swift
//  SimpleBox
//
//  Created by Bratislav Ljubisic on 30.01.21.
//

import SwiftUI

@main
struct SimpleBoxApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
      WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
