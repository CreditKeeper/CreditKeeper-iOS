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
    @State private var searchText : String = ""
    @State private var showTabView = true
    @State private var registeringUser = false
    @State private var showSettings = false
    @State private var editProfile = false
    @StateObject var viewModel : MainViewModel
    
    var body: some View {
        if (viewModel.onboarding) {
            OnboardingView(onboarding: $viewModel.onboarding)
                .transition(.move(edge: .top))
            
        } else {
            ZStack {
                Group {
                    switch (selectedTab) {
                    case .feed :
                        FeedPageView(viewModel: viewModel)
                            .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                        
                    case .ride :
                        RidePageView(viewModel: viewModel)
                            .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                        
                    case .map :
                        MapPageView(viewModel: viewModel)
                            .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                        
                    case .profile :
                        if (viewModel.loggedIn) {
                            ProfilePageView(viewModel: viewModel, showSettings: $showSettings, editProfile: $editProfile)
                                .environment(\.colorScheme, .dark)
                                .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                        } else {
                            AuthView(viewModel: viewModel, registeringUser: $registeringUser)
                                .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                        }
                    }
                }
                .ignoresSafeArea()
                
                if (viewModel.selectedRide == nil && !registeringUser && !showSettings && !editProfile) {
                    VStack {
                        if (selectedTab != .profile || viewModel.loggedIn) {
                            HeaderView(selectedTab: $selectedTab)
                                .transition(.move(edge: .top))
                        }
                        
                        Spacer()

                        TabBarView(viewModel: viewModel, selectedTab: $selectedTab, searchText: $searchText, keyboardVisible: $viewModel.keyboardVisible)
                        
                    }.transition(.opacity)
                }
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

func playHaptic() {
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
}

#Preview {
    MainView(viewModel: MainViewModel())
}


