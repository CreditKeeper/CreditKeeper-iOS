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
    var connection: PostgresConnection?
    
    init() {
        self.openConnection()
    }
    
    deinit {
        connection?.close().whenComplete { _ in
            // Handle closure completion if needed
        }
    }
    
    let logger = Logger(label: "postgres-logger")
    let config = PostgresConnection.Configuration(
        host: "209.126.87.142",
        port: 5432,
        username: "ckapp",
        password: "Helpful-Cone-Extortion2-Nebula-Repeated",
        database: "creditkeeper",
        tls: .disable)
    
    
    func openConnection() {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        PostgresConnection.connect(
            on: eventLoopGroup.next(),
            configuration: config,
            id: 1,
            logger: logger
        ).whenSuccess { connection in
                print("Connected to DB!")
                self.connection = connection
            }
    }
}
