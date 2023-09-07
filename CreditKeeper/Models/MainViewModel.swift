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

@MainActor
final class MainViewModel: ObservableObject {
    @Published var rides = [Ride]()
    @Published var parks = [Park]()
    @Published var myCredits = [Credit]()
    @Published var latestCredits = [Credit]()
    @Published var firestoreManager = FirestoreManager()
    @Published var selectedRide : Ride? = nil
    @Published var selectedPark : Park? = nil
    @Published var locationManager: CLLocationManager = CLLocationManager()
    @Published var locationEnabled: Bool = false
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075))
    @Published var loggedIn = false
    @Published var currentUser : User?
    @Published var authError = ""
    @Published var showAuth = false
    @Published var loginType = ""
    @Published var onboarding = false
    @AppStorage("onboarding") var onboardingUD = true
    
    let defaults = UserDefaults.standard
    
    init() {
        print("Initializing MVM")
        
        if (!self.loggedIn) {

            if let storedUser = Auth.auth().currentUser {
                self.loggedIn = true
                self.initUser(user: storedUser)
                getMyCredits()
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
        getAllRides()
    }
      
    func getAllParks() {
        print("Retrieving all parks from Firebase...")
        var parks = [Park]()
        
        Task.init {
            do {
                let query = try await self.firestoreManager.db.collection("park").getDocuments(source: .server)
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
    
    func getAllRides() {
        print("Retrieving all rides from Firebase...")
        var rides = [Ride]()
        
        Task.init {
            do {
                let query = try await self.firestoreManager.db.collection("ride").getDocuments(source: .server)
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
    // this is currently getting all credits, change it to get my credits.
    func getMyCredits() {
        print("Retrieving my credits from Firebase...")
        var credits = [Credit]()
        
        Task.init {
            do {
                let query = try await self.firestoreManager.db.collection("credit").getDocuments(source: .server)
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
        let date = Date()
        ref = self.firestoreManager.db.collection("credit").addDocument(data: [
            "userID": self.currentUser?.id ?? "",
            "rideID": ride,
            "created": date.description
        ]) { err in
            if let err = err {
                print("Error adding credit document: \(err)")
                completion(false)
            } else {
                print("Credit document added with ID: \(ref!.documentID)")
                withAnimation {
                    self.myCredits.append(Credit(id: ref!.documentID, userID: self.currentUser?.id ?? "", rideID: ride, created: date))
                    completion(true)
                }
            }
        }
    }
    
    func checkCredit(ride: String) -> Bool {
        return self.myCredits.contains(where: {$0.rideID == ride})
    }
    
    // don't think this works right yet
    func rodeToday(ride: String) -> Bool {
        var credit = self.myCredits.first(where: {$0.rideID == ride && $0.created == Date()})
        return credit != nil
    }
    
    // dont' think this works right yet. returning too early?
    func getRating(rideID: String) -> Rating {
        print("Retreiving Rating...")
        var rating = Rating(id: "", userID: "", rideID: "", rating: 0)
        
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
        let date = Date()
        ref = self.firestoreManager.db.collection("rating").addDocument(data: [
            "userID": self.currentUser?.id ?? "",
            "rideID": ride,
            "created": date.description,
            "rating": rating
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

    func createUser(email: String, password: String, handle: String, _ completion: @escaping (Bool) -> Void) {
        usernameIsAvailable(username: handle, { available in
            if (!available) {
                self.authError = "Username is already in use."
                completion(false)
                return
            } else {
                Task.init {
                    do {
                        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            if let error = error {
                                // there was an error creating the user
                                print("Error creating user: \(error)")
                                self.authError = error.localizedDescription
                            } else {
                                self.authError = ""
                                // user was successfully created
                                if let authResult = authResult {
                                    print("Successfully created user: \(authResult.user)")
                                    self.loggedIn = true
                                    self.showAuth = false
                                    let newUser = User(id: UUID().uuidString, handle: handle, email: email, favPark: "", admin: false, joined: Date())
                                    self.currentUser = newUser
                                    self.writeUserDocument(user: self.currentUser!)
                                    completion(true)
                                }
                            }
                        }
                    }
                }
            }
        })
    }
    
    func writeUserDocument(user: User) {
        let db = Firestore.firestore()
        let userRef = db.collection("user").document(user.id)
        
        userRef.setData(["handle": user.handle,"email": self.currentUser?.email ?? "", "bio": "", "admin": false, "pro": false, "authID": self.currentUser?.id ?? ""]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func initUser(user: FirebaseAuth.User?) {
        withAnimation {
            self.loggedIn = true
            self.showAuth = false
        }
        
        let userDocRef = Firestore.firestore().collection("user").document(user!.uid)
        userDocRef.getDocument { (snapshot, error) in
            if error == nil && snapshot?.exists == false {
                self.authError = "An error has occured. Network connection lost or no account found!"
            } else if snapshot?.exists == true {
                self.currentUser = self.firestoreManager.makeUser(document: snapshot!)
            }
        }
    }
    
    func usernameIsAvailable(username: String, _ completion: @escaping (Bool) -> Void) {
        // Get a reference to the users collection
        let db = Firestore.firestore()
        let usersRef = db.collection("user")
        
        // Create a query to get the user document with the specified username
        let query = usersRef.whereField("username", isEqualTo: username)
        
        // Get the query snapshot
        query.getDocuments() { snapshot, error in
            if let error = error {
                // there was an error querying the collection
                print("Error querying users collection: \(error)")
                completion(false)
            } else {
                // check if a user document with the specified username was found
                if snapshot!.documents.count > 0 {
                    // a user document with the specified username already exists
                    print("A user with the username '\(username)' already exists.")
                    completion(false)
                } else {
                    // the username is available
                    completion(true)
                }
            }
        }
    }
}
