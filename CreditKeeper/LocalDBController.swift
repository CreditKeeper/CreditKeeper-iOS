//
//  LocalDBManager.swift
//  CreditKeeper
//
//  Created by Nicholas Yoder on 9/10/23.
//

import Foundation

import SQLite
import UniformTypeIdentifiers

// Park Expressions
let id = Expression<Int>("id")
let name = Expression<String>("name")
let address = Expression<String>("address")
let city = Expression<String>("city")
let region = Expression<String>("region")
let country = Expression<String>("country")
let owner = Expression<String>("owner")
let link = Expression<String>("link")
let status = Expression<String>("link")
let telephone = Expression<String>("telephone")

// Ride Expressions
let rideID = Expression<String>("ride_id")
let parkID = Expression<String>("park_id")
let legacy = Expression<Bool>("legacy")
let description = Expression<String>("description")
let opening = Expression<Date>("opening")
let closing = Expression<Date>("closing")
let thrillLevel = Expression<String>("thrill")
let type = Expression<String>("type")
let height = Expression<Float>("height")
let length = Expression<Float>("length")
let speed = Expression<Float>("speed")
let inversions = Expression<Int>("inversions")
let manufacturer = Expression<String>("manufacturer")
let gforce = Expression<Float>("gforce")
let previousRideID = Expression<String>("pride_id")

struct LocalDBController {
    static let shared = LocalDBController()
    
    let db: Connection?
    let parks = Table("park")
    let rides = Table("ride")
    
    init() {
        do {
            db = try Connection(Bundle.main.url(forResource: "ckdata", withExtension: "db")!.absoluteString)
        } catch {
            db = nil
            print(error)
        }
    }
    
    func get_parks(){
        do {
            if db != nil {
                let db = db!
                for park in try db.prepare(parks) {
                    print(park[name])
                }
            } else {
                print("No DB?")
            }
        } catch {
            print(error)
        }
    }
    func get_rides(){
        do {
            if db != nil {
                let db = db!
                for ride in try db.prepare(rides) {
                    print(ride[name])
                }
            }
        } catch {
            print(error)
        }
    }
}
