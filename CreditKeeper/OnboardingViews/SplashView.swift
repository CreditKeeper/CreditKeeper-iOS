//
//  SplashView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct SplashView: View {
    @Binding var onboardingPage : OnboardingPage
    
    var body: some View {
        ZStack {
            VStack {
                Text("CreditKeeper")
                    .font(.largeTitle)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        onboardingPage = .credits
                    }
                }, label: {
                    ZStack {
                        Capsule()
                            .frame(width: nil, height: 80)
                        
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
    SplashView(onboardingPage: .constant(.splash))
}
