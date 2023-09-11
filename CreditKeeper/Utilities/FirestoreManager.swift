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
    
    func makePark(document: QueryDocumentSnapshot) -> Park {
        let id = document.documentID
        let data = document.data()
        let address = data["address"] as? String ?? ""
        let city = data["city"] as? String ?? "Unknown"
        let region = data["region"] as? String ?? "Unknown"
        let country = data["country"] as? String ?? "Unknown"
        let name = data["name"] as? String ?? "Unknown"
        let owner = data["owner"] as? String ?? "Unknown"
        let link = data["link"] as? String ?? ""
        let status = data["status"] as? String ?? ""
        let telephone = data["telephone"] as? String ?? ""
        let lastEdited = data["lastEdited"] as? Date ?? Date()
        
        return Park(id: id, address: address, city: city, region: region, country: country, name: name, owner: owner, link: link, status: status, telephone: telephone, lastEdited: lastEdited)
    }
    
    func makeRide(document: QueryDocumentSnapshot) -> Ride {
        let id = document.documentID
        let data = document.data()
        let name = data["name"] as? String ?? "Unknown"
        let parkID = data["parkID"] as? String ?? ""
        let legacy = data["legacy"] as? Bool ?? false
        let description = data["description"] as? String ?? "No description provided"
        let opening = data["opening"] as? Date ?? Date()
        let closing = data["closing"] as? Date ?? Date()
        let thrillLevel = data["thrillLevel"] as? String ?? "Unknown"
        let type = data["type"] as? String ?? "Unknown"
        let height = data["height"] as? Float ?? 0.00
        let length = data["length"] as? Float ?? 0.00
        let speed = data["speed"] as? Float ?? 0.00
        let inversions = data["inversions"] as? Int ?? 0
        let manufacturer = data["manufacturer"] as? String ?? "Unknown"
        let gforce = data["gforce"] as? Float ?? 0.0
        let duration = data["duration"] as? Float ?? 0.0
        let capacity = data["capacity"] as? Int ?? 1
        let previousRideID = data["previousRideID"] as? String ?? ""
        let averageRating = data["averageRating"] as? Float ?? 0.0
        let lastEdited = data["lastEdited"] as? Date ?? Date()
        
        return Ride(id: id, name: name, parkID: parkID, legacy: legacy, description: description, opening: opening, closing: closing, thrillLevel: thrillLevel, type: type, height: height, length: length, speed: speed, inversions: inversions, manufacturer: manufacturer, gforce: gforce, duration: duration, capacity: capacity, previousRideID: previousRideID, averageRating: averageRating, lastEdited: lastEdited)
    }
    
    func makeCredit(document: DocumentSnapshot) -> Credit {
        let id = document.documentID
        let data = document.data()
        let rideID = data?["rideID"] as? String ?? ""
        let userID = data?["userID"] as? String ?? ""
        let likes = data?["likes"] as? Int ?? 0
        let claimDate = data?["claimDate"] as? Date ?? Date()
        let lastRode = data?["lastRode"] as? Date ?? Date()
        
        return Credit(id: id, rideID: rideID, userID: userID, likes: likes, claimDate: claimDate, lastRode: lastRode)
    }
    
    func makeUser(document: DocumentSnapshot) -> User {
        let id = document.documentID
        let data = document.data()
        let handle = data?["handle"] as? String ?? "Unknown"
        let email = data?["email"] as? String ?? ""
        let admin = data?["admin"] as? Bool ?? false
        let bio = data?["bio"] as? String ?? ""
        let pro = data?["pro"] as? Bool ?? false
        let favoritePark = data?["favoritePark"] as? String ?? ""
        let topFive = data?["topFive"] as? Array<String> ?? Array<String>()
        let profileImage = data?["profileImage"] as? String ?? ""
        let joined = data?["joined"] as? Date ?? Date()
        
        return User(id: id, handle: handle, email: email, admin: admin, bio: bio, pro: pro, favoritePark: favoritePark, topFive: topFive, profileImage: profileImage, joined: joined)
    }
    
    func makeRelation(document: DocumentSnapshot) -> Relation {
        let id = document.documentID
        let data = document.data()
        let followerID = data?["followerID"] as? String ?? ""
        let followingID = data?["followingID"] as? String ?? ""
        let created = data?["created"] as? Date ?? Date()
        
        return Relation(id: id, followerID: followerID, followingID: followingID, created: created)
    }

    func makeRating(document: DocumentSnapshot) -> Rating {
        let id = document.documentID
        let data = document.data()
        let userID = data?["userID"] as? String ?? "Unknwon"
        let rideID = data?["rideID"] as? String ?? ""
        let rating = data?["rating"] as? Int ?? 0
        let editedAt = data?["editedAt"] as? Date ?? Date()
        
        return Rating(id: id, userID: userID, rideID: rideID, rating: rating, editedAt: editedAt)
    }
    
    func makeNews(document: DocumentSnapshot) -> News {
        let id = document.documentID
        let data = document.data()
        let displayName = data?["displayName"] as? String ?? ""
        let header = data?["header"] as? String ?? ""
        let body = data?["body"] as? String ?? ""
        let symbol = data?["symbol"] as? String ?? ""
        let symbolColor = data?["symbolColor"] as? String ?? "white"
        
        return News(id: id, displayName: displayName, header: header, body: body, symbol: symbol, symbolColor: symbolColor)
    }
}
