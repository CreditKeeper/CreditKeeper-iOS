//
//  OnboardingView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

enum OnboardingPage: String, CaseIterable {
    case splash
    case credits
    case terms
    case phone
}

struct OnboardingView: View {
    @Binding var onboarding : Bool
    @State private var onboardingPage : OnboardingPage = .splash
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [getBackgroundColor(page: onboardingPage), .black, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            switch (onboardingPage) {
            case .splash:
                SplashView(onboardingPage: $onboardingPage)
                    .transition(.move(edge: .trailing))
            case .credits:
                IntroToCreditView(onboardingPage: $onboardingPage)
                    .transition(.move(edge: .trailing))
            case .terms:
                TermsConditionsView(onboardingPage: $onboardingPage)
                    .transition(.move(edge: .trailing))
            case .phone:
                NoPhoneOnCoasterView(onboarding: $onboarding)
                    .transition(.move(edge: .trailing))
            }
        }
    }
    
    func getBackgroundColor(page: OnboardingPage)->Color {
        switch (page) {
        case .splash :
            return .blue
        case .credits :
            return .red
        case .terms :
            return .green
        case .phone :
            return .orange
        }
    }
}

#Preview {
    OnboardingView(onboarding: .constant(true))
}
