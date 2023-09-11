//
//  RideModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import Foundation

struct Ride: Identifiable, Hashable {
    var id: String
    let name: String
    let parkID: String
    let legacy: Bool
    let description: String
    let opening: Date
    let closing: Date
    let thrillLevel: String
    let type: String
    let height: Float
    let length: Float
    let speed: Float
    let inversions: Int
    let manufacturer: String
    let gforce: Float
    let duration: Float
    let capacity: Int
    let previousRideID: String
    let averageRating: Float
    let lastEdited: Date
    
}
