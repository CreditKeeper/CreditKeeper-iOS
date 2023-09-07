//
//  NewsModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/7/23.
//

import Foundation

struct News: Identifiable {
    var id: String
    let displayName: String
    let header: String
    let body: String
    let symbol: String
    let symbolColor: String
}
