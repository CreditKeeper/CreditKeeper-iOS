//
//  MainViewModel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/1/23.
//

import Foundation
import CoreLocation

@MainActor
final class MainViewModel: ObservableObject {
    @Published var rides = [Ride]()
    @Published var parks = [Park]()
    @Published var firestoreManager = FirestoreManager()
    @Published var selectedRide : Ride? = nil
    @Published var selectedPark : Park? = nil
//    @Published var locationManager: CLLocationManager = CLLocationManager()
//    @Published var locationEnabled: Bool = false
    
    init() {
        print("Initializing MVM")
        
        // MARK : Location Initialization
//        if CLLocationManager.locationServicesEnabled() {
//            switch locationManager.authorizationStatus {
//            case .notDetermined, .restricted, .denied:
//                print("Failed to get location")
//                self.locationEnabled = false
//            case .authorizedAlways, .authorizedWhenInUse:
//                print("Succeeded in getting location ")
//                self.locationEnabled = true
//            @unknown default:
//                break
//            }
//        } else {
//            print("Location services are disabled by user")
//        }
        
        getAllParks()
        getAllRides()
        
        print("MVM init complete")
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
}
