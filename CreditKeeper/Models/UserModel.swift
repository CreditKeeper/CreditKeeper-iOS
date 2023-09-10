//
//  UserModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import Foundation

struct User: Identifiable, Hashable {
    var id: String
    var handle: String
    let email: String
    let admin: Bool
    let bio: String
    let pro: Bool
    let favoritePark: String
    let topFive: Array<String>
    let profileImage: String
    let joined: Date
}
