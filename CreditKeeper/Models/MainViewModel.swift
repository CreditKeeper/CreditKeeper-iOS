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
                                    //self.writeUserDocument(user: self.currentUser!)
                                    completion(true)
                                }
                            }
                        }
                    }
                }
            }
        })
    }
    
    func usernameIsAvailable(username: String, _ completion: @escaping (Bool) -> Void) {
        // Get a reference to the users collection
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        
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
