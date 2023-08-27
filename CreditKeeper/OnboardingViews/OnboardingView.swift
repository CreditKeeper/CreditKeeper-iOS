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
    @State private var onboardingPage : OnboardingPage = .splash
    @Binding var onboarding : Bool
    
    var body: some View {
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

#Preview {
    OnboardingView(onboarding: .constant(true))
}
