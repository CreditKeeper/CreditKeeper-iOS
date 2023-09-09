//
//  ProfilePageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

struct ProfilePageView: View {
    @StateObject var viewModel : MainViewModel
    @Binding var showSettings : Bool
    @Binding var editProfile : Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .profile), .black, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HStack {
                        Circle()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.thinMaterial)
                        
                        Text(viewModel.currentUser?.handle ?? "")
                            .font(.largeTitle)
                            .multilineTextAlignment(.leading)
                            .shadow(radius: 4)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Rectangle()
                        .frame(width: nil, height: 100)
                        .cornerRadius(20)
                        .foregroundStyle(.thinMaterial)
                        .padding(.horizontal)
                    
                    ProfileSettingCapsules(showSettings: $showSettings, editProflie: $editProfile)
                    
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
            .padding(.top, 110)
            
            if (showSettings) {
                SettingsPageView(viewModel: viewModel, showSettings: $showSettings)
            }
        }
    }
}

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        ProfilePageView(viewModel: MainViewModel(), showSettings: .constant(false), editProfile: .constant(false))

    }
}
