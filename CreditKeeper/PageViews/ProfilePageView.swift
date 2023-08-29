//
//  ProfilePageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

struct ProfilePageView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.thinMaterial)
                    
                    Rectangle()
                        .frame(width: nil, height: 100)
                        .cornerRadius(20)
                        .foregroundStyle(.thinMaterial)
                }
                .padding()
                
                ProfileSettingCapsules()
                
                Rectangle()
                    .frame(width: nil, height: 50)
                    .cornerRadius(20)
                    .foregroundStyle(.thinMaterial)
                    .padding(.horizontal)
                
                Rectangle()
                    .frame(width: nil, height: 50)
                    .cornerRadius(20)
                    .foregroundStyle(.thinMaterial)
                    .padding(.horizontal)
                
                Rectangle()
                    .frame(width: nil, height: 50)
                    .cornerRadius(20)
                    .foregroundStyle(.thinMaterial)
                    .padding(.horizontal)
                
                Rectangle()
                    .frame(width: nil, height: 50)
                    .cornerRadius(20)
                    .foregroundStyle(.thinMaterial)
                    .padding(.horizontal)
                
                Rectangle()
                    .frame(width: nil, height: 50)
                    .cornerRadius(20)
                    .foregroundStyle(.thinMaterial)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                Rectangle()
                    .frame(width: nil, height: 2)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                
                ZStack {
                    Rectangle()
                        .frame(width: nil, height: 20000)
                        .foregroundStyle(.thickMaterial)
                    
                    VStack {
                        Text("Your Credits")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .padding()
                        
                        Spacer()
                    }
                }
            }
        }
        .padding(.top, 50)
    }
}

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        ProfilePageView()
    }
}
