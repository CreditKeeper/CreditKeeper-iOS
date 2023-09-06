//
//  SettingsPageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct SettingsPageView: View {
    @StateObject var viewModel : MainViewModel
    @Binding var showSettings : Bool
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Settings")
                        .bold()
                        .foregroundStyle(.white)
                        .font(.title)
                    
                    Spacer()
                    
                    Button (action: {
                        
                    }, label: {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 25))
                            .foregroundStyle(.white)
                    })
                }
                
                Spacer()
                
                
                // stuff
                
                
                Spacer()
                
                Button (action: {
                    showSettings = false
                }, label: {
                    ZStack {
                        Capsule()
                            .foregroundStyle(.white)
                            .frame(width: 100, height: 50)
                        
                        Text("Close")
                            .bold()
                            .font(.title2)
                            .foregroundStyle(.orange)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [.orange, .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        SettingsPageView(viewModel: MainViewModel(), showSettings: .constant(true))
    }
}
