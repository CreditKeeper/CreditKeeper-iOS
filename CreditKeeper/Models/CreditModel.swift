//
//  CreditModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import Foundation

struct Credit: Identifiable {
    var id: String
    let userID: String
    let rideID: String
    let created: Date
}
