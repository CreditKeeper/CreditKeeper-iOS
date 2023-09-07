//
//  RelationModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/7/23.
//

import Foundation

struct Relation: Identifiable, Hashable {
    var id: String
    let followerID: String
    let followingID: String
    let created: Date
}
