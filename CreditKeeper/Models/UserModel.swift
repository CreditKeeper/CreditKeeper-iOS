//
//  UserModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct User: Identifiable {
    var id: String
    let handle: String
    let email: String
    let favPark: String
    let admin: Bool
    let joined: Date
}
