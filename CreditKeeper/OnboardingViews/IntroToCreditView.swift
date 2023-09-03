//
//  IntroToCreditView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct IntroToCreditView: View {
    @State private var hasTimeElapsed = false
    @Binding var onboardingPage : OnboardingPage
    
    var body: some View {
        ZStack {
            VStack {
                Text("Coaster Credits?")
                    .font(.system(size: 40))
                    .bold()
                    .italic()
                    .shadow(radius: 10)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .task(delayText)
                
                Text("In the roller coaster community, a Credit is a rollercoaster. To earn a credit, is to conquer that roller coaster by riding it.\n\nCreditKeeper is here to help you track, share, and learn more about your earned credits on roller coasters big and small.")
                    .padding()
                    .foregroundStyle(.white)
                
                Spacer()
                
                if (hasTimeElapsed) {
                    ZStack {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 200)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 100))
                            .foregroundStyle(.green)
                    }
                    .shadow(radius: 10)
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        onboardingPage = .terms
                    }
                }, label: {
                    ZStack {
                        Capsule()
                            .frame(width: 160, height: 50)
                            .foregroundStyle(Color("uiCapsuleRed"))
                            .shadow(radius: 10)
                        
                        Text("Ah, Gotcha")
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
    IntroToCreditView(onboardingPage: .constant(.credits))
}
