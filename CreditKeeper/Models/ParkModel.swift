//
//  ParkModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct Park: Identifiable {
    var id: String
    let name: String
    let city: String
    let region: String
    let country: String
    let owner: String
    let description: String
}
