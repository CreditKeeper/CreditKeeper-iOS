//
//  AppDelegate.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI
import FirebaseCore
import Combine

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Getting Parks")
        LocalDBController.shared.get_parks()
        print("Getting Rides")
        LocalDBController.shared.get_rides()
        
        FirebaseApp.configure()
        
        UITableView.appearance().backgroundColor = UIColor.clear
        
        return true
    }
}
