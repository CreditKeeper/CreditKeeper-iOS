//
//  ServerManager.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/30/23.
//

import Foundation
import SwiftUI
import PostgresNIO
import Logging

class ServerManager: ObservableObject {
    let logger = Logger(label: "postgres-logger")
    let config = PostgresConnection.Configuration(
        host: "209.126.87.142",
        port: 5432,
        username: "ckapp",
        password: "Helpful-Cone-Extortion2-Nebula-Repeated",
        database: "creditkeeper",
        tls: .disable)
    
    
    func openConnection() async {
        do {
            let connection = try await PostgresConnection.connect(
                configuration: config,
                id: 1,
                logger: logger)
        } catch {
            print("CRITICAL ERROR - Could not open connection to CreditKeeper server!")
        }
    }
}
