//
//  TermsConditionsView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct TermsConditionsView: View {
    @State private var hasTimeElapsed = false
    @Binding var onboardingPage : OnboardingPage
    
    var body: some View {
        ZStack {
            VStack {
                Text("Terms & Conditions")
                    .font(.system(size: 30))
                    .bold()
                    .italic()
                    .shadow(radius: 10)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .task(delayText)
                
                // INSERT TERMS AND CONDITIONS
                
                Spacer()
                
                if (hasTimeElapsed) {
                    Button(action: {
                        playHaptic()
                        withAnimation {
                            onboardingPage = .phone
                        }
                    }, label: {
                        ZStack {
                            Capsule()
                                .frame(width: 150, height: 50)
                                .foregroundStyle(Color("uiCapsuleGreen"))
                                .shadow(radius: 10)
                            
                            Text("I Agree")
                                .foregroundStyle(.white)
                                .font(.title)
                        }
                    })
                    .padding()
                }
            }
        }
    }
    
    private func delayText() async {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        withAnimation {
            hasTimeElapsed = true
        }
    }
}

#Preview {
    TermsConditionsView(onboardingPage: .constant(.phone))
}
