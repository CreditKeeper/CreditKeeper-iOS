//
//  ParkModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import Foundation
import CoreLocation

struct Park: Identifiable {
    var id: String
    let name: String
    let address: String
    let city: String
    let region: String
    let country: String
    let owner: String
    let link: String
    let phone: String
    let location: CLLocation
}
