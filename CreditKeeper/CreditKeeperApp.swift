//
//  CreditKeeperApp.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/24/23.
//

import SwiftUI

@main
struct CreditKeeperApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewModel = MainViewModel()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
