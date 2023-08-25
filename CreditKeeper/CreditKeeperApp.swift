//
//  CreditKeeperApp.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/24/23.
//

import SwiftUI

@main
struct CreditKeeperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
