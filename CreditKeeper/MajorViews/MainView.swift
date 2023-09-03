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
    @State private var showTabView = true
    @State private var selectedRide : Ride? = nil
    @StateObject var viewModel : MainViewModel
    
    var body: some View {
        if (onboarding && UserDefaults.standard.bool(forKey: "KeyOnBoardingViewShown") == false) {
            OnboardingView(onboarding: $onboarding)
                .transition(.move(edge: .trailing))
            
        } else {
            ZStack {
                Group {
                    switch (selectedTab) {
                    case .feed :
                        FeedPageView()
                        
                    case .ride :
                        RidePageView(viewModel: viewModel, selectedRide: $selectedRide)
                        
                    case .map :
                        MapPageView()
                        
                    case .profile :
                        ProfilePageView()
                            .environment(\.colorScheme, .dark)
                        
                    }
                }
                .ignoresSafeArea()
                
                if (selectedRide == nil) {
                    VStack {
                        HeaderView(selectedTab: $selectedTab)
                        
                        Spacer()
                        
                        TabBarView(selectedTab: $selectedTab, searchText: $searchText)
                    }.transition(.opacity)
                }
            }
            .transition(.move(edge: .trailing))
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

#Preview {
    MainView(viewModel: MainViewModel())
}


