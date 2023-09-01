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
    @State private var searchText : String = ""
    @StateObject var viewModel : MainViewModel
    
    var body: some View {
        if (onboarding && UserDefaults.standard.bool(forKey: "KeyOnBoardingViewShown") == false) {
            OnboardingView(onboarding: $onboarding)
            
        } else {
            ZStack {
                TabView(selection: $selectedTab) {
                    ZStack {
                        RadialGradient(gradient: Gradient(colors: [getBackgroundColor(tab: selectedTab), .black]), center: .center, startRadius: 2, endRadius: 650)
                            .ignoresSafeArea()
                        
                        switch (selectedTab) {
                        case .feed :
                            FeedPageView()
                                .tag("feed")
                            
                        case .ride :
                            RidePageView(viewModel: viewModel)
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
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
                
                VStack {
                    HeaderView(selectedTab: $selectedTab)
                    
                    Spacer()
                    
                    TabBarView(selectedTab: $selectedTab, searchText: $searchText)
                }
            }
        }
    }
    
    func getBackgroundColor(tab: Tab) -> Color {
        switch (tab) {
        case .feed :
            return .blue
        case .ride :
            return .red
        case .map :
            return .clear
        case .profile :
            return .orange
        }
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}


