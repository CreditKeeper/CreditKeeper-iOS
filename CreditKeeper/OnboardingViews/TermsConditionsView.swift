//
//  TermsConditionsView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct TermsConditionsView: View {
    @Binding var onboardingPage : OnboardingPage
    
    var body: some View {
        ZStack {
            VStack {
                Text("Terms and Conditions")
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        onboardingPage = .phone
                    }
                }, label: {
                    ZStack {
                        Capsule()
                            .frame(width: 160, height: 60)
                            .foregroundStyle(Color("uiCapsuleGreen"))
                        
                        Text("Continue")
                            .foregroundStyle(.white)
                            .font(.title)
                    }
                })
            }
        }
    }
}

#Preview {
    TermsConditionsView(onboardingPage: .constant(.phone))
}
