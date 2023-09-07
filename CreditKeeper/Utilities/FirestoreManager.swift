//
//  FirestoreManager.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import CoreLocation

class FirestoreManager {
    var lastDocument : QueryDocumentSnapshot?
    let db = Firestore.firestore() // Firestore Initialization
    let geoCoder = CLGeocoder()
    
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
        let owner = data["owner"] as? String ?? "Unknown"
        let address = data["address"] as? String ?? ""
        let city = data["city"] as? String ?? "Unknown"
        let region = data["region"] as? String ?? "Unknown"
        let country = data["country"] as? String ?? "Unknown"
        let link = data["link"] as? String ?? ""
        let phone = data["telephone"] as? String ?? ""
        
        let location = CLLocation() // this needs fixed to get location from address
        
        return Park(id: id, name: name, address: address, city: city, region: region, country: country, owner: owner, link: link, phone: phone, location: location)
    }
    
    func makeUser(document: DocumentSnapshot) -> User {
        let id = document.documentID
        let data = document.data()
        let handle = data?["handle"] as? String ?? "Unknown"
        let email = data?["email"] as? String ?? ""
        let favPark = data?["favPark"] as? String ?? ""
        let admin = data?["admin"] as? Bool ?? false
        let joined = data?["joined"] as? Date ?? Date()
        
        return User(id: id, handle: handle, email: email, favPark: favPark, admin: admin, joined: joined)
    }
    
    func makeCredit(document: DocumentSnapshot) -> Credit {
        let id = document.documentID
        let data = document.data()
        let userID = data?["userID"] as? String ?? "Unknown"
        let rideID = data?["rideID"] as? String ?? ""
        let created = data?["created"] as? Date ?? Date()
        
        return Credit(id: id, userID: userID, rideID: rideID, created: created)
    }
    
    func makeRating(document: DocumentSnapshot) -> Rating {
        let id = document.documentID
        let data = document.data()
        let userID = data?["userID"] as? String ?? "Unknwon"
        let rideID = data?["rideID"] as? String ?? ""
        let rating = data?["rating"] as? Int ?? 0
        
        return Rating(id: id, userID: userID, rideID: rideID, rating: rating)
    }
}
