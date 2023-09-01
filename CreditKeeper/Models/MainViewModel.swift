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
        
        getAllRides()
        getAllParks()
        print("MVM init complete")
    }
        
    func getAllRides() {
        print("Retrieving all rides from Firebase...")
        
        Task.init {
            do {
                let gatheredRides = try await self.firestoreManager.makeAllRides()
                if (gatheredRides.count > 0) {
                    self.rides.append(contentsOf: gatheredRides)
                    print("Rides gathered!")
                } else {
                    print("Got zero rides.")
                }
            }
        }
    }
    
    func getAllParks() {
        print("Retrieving all parks from Firebase...")
        
        Task.init {
            do {
                let gatheredParks = try await self.firestoreManager.makeAllParks()
                if (gatheredParks.count > 0) {
                    self.parks.append(contentsOf: gatheredParks)
                    print("Parks gathered!")
                } else {
                    print("Got zero parks.")
                }
            }
        }
    }
}
