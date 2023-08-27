//
//  NoPhoneOnCoasterView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct NoPhoneOnCoasterView: View {
    @Binding var onboarding : Bool
    
    var body: some View {
        ZStack {
            VStack {
                Text("One more thing...")
                    .font(.largeTitle)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        onboarding = false
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
    NoPhoneOnCoasterView(onboarding: .constant(true))
}
