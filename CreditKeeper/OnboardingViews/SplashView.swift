//
//  SplashView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct SplashView: View {
    @State private var hasTimeElapsed = false
    @Binding var onboardingPage : OnboardingPage
    
    var body: some View {
        ZStack {
            VStack {
                Text("Welcome To")
                    .bold()
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .transition(.slide)
                    .padding(.top)
                
                Image("creditKeeper")
                    .colorInvert()
                    .shadow(radius: 10)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .task(delayText)
                
                if (hasTimeElapsed) {
                    Text("The best place to claim your coasters!")
                        .bold()
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .transition(.scale)
                }
                
                Image("rollercoaster")
                    .colorInvert()
                    .shadow(radius: 10)
                
                Spacer()
                
                Text("Just a bit of info to cover first!")
                    .bold()
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    .transition(.slide)
                
                Button(action: {
                    playHaptic()
                    withAnimation {
                        onboardingPage = .credits
                    }
                }, label: {
                    ZStack {
                        Capsule()
                            .frame(width: 140, height: 50)
                            .foregroundStyle(Color("uiCapsuleBlue"))
                            .shadow(radius: 10)
                        
                        Text("Let's Go!")
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                })
            }
            .padding()
        }
    }
    
    private func delayText() async {
        try? await Task.sleep(nanoseconds: 500_000_000)
        withAnimation {
            hasTimeElapsed = true
        }
    }
}

#Preview {
    SplashView(onboardingPage: .constant(.splash))
}
