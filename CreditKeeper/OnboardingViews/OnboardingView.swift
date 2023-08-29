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
            RadialGradient(gradient: Gradient(colors: [getBackgroundColor(page: onboardingPage), .black]), center: .center, startRadius: 2, endRadius: 650)
                .ignoresSafeArea()
            
            switch (onboardingPage) {
            case .splash:
                SplashView(onboardingPage: $onboardingPage)
            case .credits:
                IntroToCreditView(onboardingPage: $onboardingPage)
            case .terms:
                TermsConditionsView(onboardingPage: $onboardingPage)
            case .phone:
                NoPhoneOnCoasterView(onboarding: $onboarding)
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
