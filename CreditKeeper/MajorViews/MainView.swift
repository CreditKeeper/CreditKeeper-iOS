//
//  ContentView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/24/23.
//

import SwiftUI
import CoreData

struct MainView: View {
    @State private var selectedTab : Tab = .feed
    @State private var onboarding : Bool = true
    
    init () {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        if (onboarding && UserDefaults.standard.bool(forKey: "KeyOnBoardingViewShown") == false) {
            OnboardingView(onboarding: $onboarding)
            
        } else {
            ZStack {
                TabView(selection: $selectedTab) {
                    ZStack {
                        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
                            .ignoresSafeArea()
                        
                        switch (selectedTab) {
                        case .feed :
                            FeedPageView()
                                .tag("feed")
                            
                        case .ride :
                            RidePageView()
                                .tag("rides")
                            
                        case .map :
                            MapPageView()
                                .tag("map")
                            
                        case .profile :
                            ProfilePageView()
                                .tag("profile")
                        }
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
}

#Preview {
    MainView()
}


