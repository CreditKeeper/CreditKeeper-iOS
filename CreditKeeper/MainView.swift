//
//  ContentView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/24/23.
//

import SwiftUI
import CoreData

struct MainView: View {
    @State private var selectedTab : Tab = .ride
    
    init () {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                switch (selectedTab) {
                case .feed :
                    FeedPageView()
                    
                case .ride :
                    RidePageView()
                    
                case .map :
                    MapPageView()
                    
                case .profile :
                    ProfilePageView()
                    
                }
            }
            
            VStack {
                HeaderView(selectedTab: $selectedTab)
                
                Spacer()
                
                TabBarView(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    MainView()
}


