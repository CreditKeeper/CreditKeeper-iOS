//
//  NoPhoneOnCoasterView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct NoPhoneOnCoasterView: View {
    @Binding var onboarding : Bool
    @State private var hasTimeElapsed = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("Never use your phone on a ride!")
                    .font(.system(size: 30))
                    .bold()
                    .italic()
                    .shadow(radius: 10)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .task(delayText)
                
                Spacer()
                
                ZStack {
                    Image(systemName: "smartphone")
                        .font(.system(size: 100))
                        .foregroundStyle(.white)
                    
                    Image(systemName: "circle.slash")
                        .font(.system(size: 200))
                        .foregroundStyle(.red)
                }
                .shadow(radius: 10)
                
                Text("Every year, people are injured by cell phone use on rides. Please, keep your cell phone in available lockers or tightly secured to clothing at all times during a ride.\n\n")
                    .padding()
                    .foregroundStyle(.white)
                
                Text("Don't ruin someone else's day!")
                    .foregroundStyle(.white)
                
                
                Spacer()
                
                if (hasTimeElapsed) {
                    Button(action: {
                        withAnimation {
                            onboarding = false
                        }
                    }, label: {
                        ZStack {
                            Capsule()
                                .frame(width: 190, height: 50)
                                .foregroundStyle(Color("uiCapsuleOrange"))
                                .shadow(radius: 10)
                            
                            Text("Aye Aye!")
                                .foregroundStyle(.white)
                                .font(.title)
                        }
                    })
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
    }
    
    private func delayText() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        withAnimation {
            hasTimeElapsed = true
        }
    }
}

#Preview {
    NoPhoneOnCoasterView(onboarding: .constant(true))
}
