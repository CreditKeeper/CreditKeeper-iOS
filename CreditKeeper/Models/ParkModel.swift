//
//  ParkModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import Foundation
import CoreLocation

struct Park: Identifiable, Hashable {
    var id: String
    let address: String
    let city: String
    let region: String
    let country: String
    let name: String
    let owner: String
    let link: String
    let status: String
    let telephone: String
    let lastEdited: Date
}
