//
//  IntroToCreditView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct IntroToCreditView: View {
    @Binding var onboardingPage : OnboardingPage
    
    var body: some View {
        ZStack {
            VStack {
                Text("What are Credits?")
                    .font(.largeTitle)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        onboardingPage = .terms
                    }
                }, label: {
                    ZStack {
                        Capsule()
                            .frame(width: 160, height: 60)
                            .foregroundStyle(Color("uiCapsuleRed"))
                        
                        Text("Continue")
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    IntroToCreditView(onboardingPage: .constant(.credits))
}
