//
//  FirestoreManager.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class FirestoreManager {
    var lastDocument : QueryDocumentSnapshot?
    let db = Firestore.firestore() // Firestore Initialization
    
    func makeRide(document: QueryDocumentSnapshot) -> Ride {
        let id = document.documentID
        let data = document.data()
        let name = data["name"] as? String ?? "Unknown"
        let parkID = data["parkID"] as? String ?? ""
        let manufacturer = data["manufacturer"] as? String ?? "Unknown"
        let opening = data["opening"] as? Date ?? Date()
        let legacy = data["legacy"] as? Bool ?? false
        let height = data["height"] as? Float ?? 0.00
        let length = data["length"] as? Float ?? 0.00
        let inversions = data["inversions"] as? Int ?? 0
        let thrillLevel = data["thrillLevel"] as? String ?? "Unknown"
        let type = data["type"] as? String ?? "Unknown"
        let speed = data["speed"] as? Float ?? 0.00
        let description = data["description"] as? String ?? "No description provided"
        return Ride(id: id, name: name, parkID: parkID, manufacturer: manufacturer, opening: opening, legacy: legacy, height: height, length: length, inversions: inversions, thrillLevel: thrillLevel, type: type, speed: speed, description: description)
    }
    
    func makePark(document: QueryDocumentSnapshot) -> Park {
        let id = document.documentID
        let data = document.data()
        let name = data["name"] as? String ?? "Unknown"
        let city = data["city"] as? String ?? "Unknown"
        let region = data["region"] as? String ?? "Unknown"
        let country = data["country"] as? String ?? "Unknown"
        let owner = data["owner"] as? String ?? "Unknown"
        let description = data["description"] as? String ?? "Unknown"
        return Park(id: id, name: name, city: city, region: region, country: country, owner: owner, description: description)
    }
}
