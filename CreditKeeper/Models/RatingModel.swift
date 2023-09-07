//
//  RatingModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/6/23.
//

import Foundation

struct Rating: Identifiable {
    var id: String
    let userID: String
    let rideID: String
    let rating: Int
}
