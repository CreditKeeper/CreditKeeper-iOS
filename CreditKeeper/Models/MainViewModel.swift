//
//  MainViewModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit
import Firebase
import FirebaseFirestore

@MainActor
class MainViewModel: ObservableObject {
    @Published var firestoreManager = FirestoreManager()
    @Published var rides = [Ride]() // all rides
    @Published var parks = [Park]() // all parks
    @Published var news = [News]() // all news
    @Published var myCredits = [Credit]() // users credits
    
    // Selection
    @Published var selectedRide : Ride? = nil // the ride, if any, currently selected in the Rides view
    @Published var selectedPark : Park? = nil // the park, if any, currently selected in the Parks view
    @Published var selectedNews : News? = nil // the news article, if any, currently selected in the Feeds view
    @Published var feedCredits : [Credit] = [] // the Credits, if any, currently displayed in the Feed view

    // Location - broken
    @Published var locationManager: CLLocationManager = CLLocationManager()
    @Published var locationEnabled: Bool = false
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075))

    // Auth
    @Published var loggedIn = false
    @Published var currentUser : User?
    @Published var authError = ""
    @Published var showAuth = false
    @Published var loginType = "" // Email, Google, or Apple
    
    // Settings
    @Published var tabBarGesture = true
    @Published var onboarding = true
    @Published var keyboardVisible = false
    
    @AppStorage("onboarding") var onboardingUD = true
    
    let defaults = UserDefaults.standard
    
    init() {
        print("Initializing MVM")
        
        if (!self.loggedIn) {

            if Auth.auth().currentUser != nil {
                withAnimation {
                    self.loggedIn = true
                    self.initUser()
                }
            }
        }
        
        self.onboarding = self.onboardingUD
        self.onboardingUD = false
        
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                print("X - Failed to get location")
                self.locationEnabled = false
            case .authorizedAlways, .authorizedWhenInUse:
                print("G - Succeeded in getting location ")
                self.locationEnabled = true
            @unknown default:
                break
            }
        } else {
            print("X - Location services are disabled by user")
        }
        
        getAllTheGoods()
        print("MVM init complete")
    }
    
    func getAllTheGoods() {
        getAllParks()
        getSomeRides()
        getNews()
        getMyCredits()
    }
      
    func getAllParks() {
        print("Retrieving all parks from Firebase...")
        var parks = [Park]()
        
        Task.init {
            do {
                let query = try await self.firestoreManager.db.collection("park")
                    .getDocuments(source: .server)
                
                for document in query.documents {
                    parks.append(self.firestoreManager.makePark(document: document))
                }
                if (parks.count > 0) {
                    self.parks.append(contentsOf: parks)
                    print("Parks gathered!")
                } else {
                    print("Got zero parks.")
                }
            }
        }
    }
    
    func getSomeRides() {
        print("Retrieving all rides from Firebase...")
        var rides = [Ride]()
        
        Task.init {
            do {
                let query = try await self.firestoreManager.db.collection("ride")
                    .limit(to: 20)
                    .getDocuments(source: .server)
                
                for document in query.documents {
                    rides.append(self.firestoreManager.makeRide(document: document))
                }
                if (rides.count > 0) {
                    self.rides = rides
                    print("Rides gathered!")
                } else {
                    print("Got zero rides.")
                }
            }
        }
    }
    
    func rideSearch(rideName: String) {
        print("Searching for rides...")
        var rides = [Ride]()
        
        Task.init {
            do {
                let query = try await self.firestoreManager.db.collection("ride")
                    .whereField("name", isEqualTo: rideName)
                    .limit(to: 20)
                    .getDocuments(source: .server)
                
                for document in query.documents {
                    rides.append(self.firestoreManager.makeRide(document: document))
                }
                if (rides.count > 0) {
                    self.rides = rides
                    print("Searched Rides gathered!")
                } else {
                    self.rides = rides
                    print("Got zero searched rides.")
                }
            }
        }
    }
    
    func getNews() {
        print("Retrieving latest news from Firebase...")
        var news = [News]()
        
        Task.init {
            do {
                let query = try await self.firestoreManager.db.collection("news")
                    .getDocuments(source: .server)
                
                for document in query.documents {
                    news.append(self.firestoreManager.makeNews(document: document))
                }
                if (news.count > 0) {
                    self.news = news
                    print("News gathered!")
                } else {
                    print("Got no news.")
                }
            }
        }
    }
    
    func getMyCredits() {
        print("Retrieving my credits from Firebase...")
        var credits = [Credit]()
        
        Task.init {
            do {
                let query = try await self.firestoreManager.db.collection("credit")
                    .whereField("userID", isEqualTo: Auth.auth().currentUser?.uid ?? 0)
                    .getDocuments(source: .server)

                for document in query.documents {
                    credits.append(self.firestoreManager.makeCredit(document: document))
                }
                if (credits.count > 0) {
                    self.myCredits = credits
                    print("Credits gathered!")
                } else {
                    print("Got zero credits.")
                }
            }
        }
    }
    
    func claimCredit(ride: String, _ completion: @escaping (Bool) -> Void) {
        var ref: DocumentReference? = nil
        ref = self.firestoreManager.db.collection("credit")
            .addDocument(data: [
            "rideID": ride,
            "userID": self.currentUser?.id ?? "",
            "likes": 0,
            "claimDate": Date(),
            "lastRode": Date()]) { err in
                
            if let err = err {
                print("Error adding credit document: \(err)")
                completion(false)
            } else {
                print("Credit document added with ID: \(ref!.documentID)")
                withAnimation {
                    self.myCredits.append(Credit(id: ref!.documentID, rideID: ride, userID: self.currentUser?.id ?? "", likes: 0, claimDate: Date(), lastRode: Date()))
                    completion(true)
                }
            }
        }
    }
    
    func updateCredit(ride: String, _ completion: @escaping (Bool) -> Void) {
        let credit = self.myCredits.first(where: {$0.rideID == ride})
        
        if (credit == nil) {
            completion(false)
        } else {
            let creditRef = self.firestoreManager.db.collection("credit").document(credit!.id)
            creditRef.updateData([
                "lastRode": Date()
            ]) { error in
                if let error = error {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
    
    func checkCredit(ride: String) -> Bool {
        return self.myCredits.contains(where: {$0.rideID == ride})
    }
    
    func rodeToday(ride: String) -> Bool {
        let credit = self.myCredits.first(where: {$0.rideID == ride})
        
        if (credit != nil) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            
            return dateFormatter.string(from: credit!.lastRode) == dateFormatter.string(from: Date())
        } else {
            return false
        }
    }
    
    // don't think this works right yet. returning too early?
    func getRating(rideID: String) -> Rating {
        print("Retreiving Rating...")
        var rating = Rating(id: "", userID: "", rideID: "", rating: 0, editedAt: Date())
        
        Task.init {
            do {
                let query = try await self.firestoreManager.db.collection("rating").getDocuments(source: .server)
                for document in query.documents {
                    rating = self.firestoreManager.makeRating(document: document)
                }
                if (rating.id != "") {
                    print("Credits gathered!")
                } else {
                    print("Got zero credits.")
                }
            }
            
        }
        return rating
    }
    
//    func updateRating(ratingID: String) -> Rating {
//        
//    }
    
    func submitRating(rating: Int, ride: String, _ completion: @escaping (Bool) -> Void) {
        var ref: DocumentReference? = nil
        ref = self.firestoreManager.db.collection("rating").addDocument(data: [
            "userID": self.currentUser?.id ?? "",
            "rideID": ride,
            "rating": rating,
            "editedAt": Date()
        ]) { err in
            if let err = err {
                print("Error adding rating document: \(err)")
                completion(false)
            } else {
                print("Rating document added with ID: \(ref!.documentID)")
                withAnimation {
                    completion(true)
                }
            }
        }
    }
}
