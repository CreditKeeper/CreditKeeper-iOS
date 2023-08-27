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
                    .font(.title2)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        onboardingPage = .phone
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
        }
    }
}

#Preview {
    TermsConditionsView(onboardingPage: .constant(.phone))
}
