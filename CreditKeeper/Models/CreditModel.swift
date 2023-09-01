//
//  CreditModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct Credit: Identifiable {
    var id: String
    let userID: String
    let rideID: String
    let created: Date
}
