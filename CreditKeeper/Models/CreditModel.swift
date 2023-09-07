//
//  CreditModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import Foundation

struct Credit: Identifiable, Hashable {
    var id: String
    let rideID: String
    let userID: String
    let type: String
    let likes: Int
    let claimDate: Date
    let lastRode: Date
}
