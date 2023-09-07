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
    let manufacturer: String
    let opening: Date
    let legacy: Bool
    let height: Float
    let length: Float
    let inversions: Int
    let thrillLevel: String
    let type: String
    let speed: Float
    let description: String
}
