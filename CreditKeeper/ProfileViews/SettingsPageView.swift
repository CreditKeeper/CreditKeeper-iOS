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
                }
                
                ScrollView {
                    ZStack {
                        SettingsCapsuleView(text: "Account:")
                        
                        HStack{
                            Spacer()
                            
                            Button (action: {
                                withAnimation {
                                    viewModel.logOut()
                                    showSettings = false
                                }
                            }, label: {
                                ZStack {
                                    Capsule()
                                        .foregroundStyle(.red)
                                        .frame(width: 85, height: 30)
                                    
                                    Text("Log Out")
                                        .bold()
                                        .font(.system(size: 15))
                                        .foregroundStyle(.white)
                                }
                            })
                            .padding(.trailing, 30)
                        }
                    }
                    
                    ZStack {
                        SettingsCapsuleView(text: "Tab Bar Gesture:")
                        
                        HStack{
                            Spacer()
                            
                            Toggle(isOn: $viewModel.tabBarGesture, label: {
                                Text("")
                            })
                            .padding(.trailing, 30)
                        }
                    }
                }
                
                HStack {
                    Button (action: {
                        
                    }, label: {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                    })
                    
                    Spacer()
                    
                    Button (action: {
                        showSettings = false
                    }, label: {
                        ZStack {
                            Capsule()
                                .foregroundStyle(.white)
                                .frame(width: 90, height: 35)
                            
                            Text("Close")
                                .bold()
                                .font(.title3)
                                .foregroundStyle(.orange)
                        }
                    })
                }
            }
            .padding(.top, 50)
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

struct SettingsCapsuleView: View {
    @State var text : String
    var body: some View {
        ZStack {
            Capsule()
                .frame(width: nil, height: 50)
                .foregroundStyle(.thinMaterial)
            
            HStack {
                Text(text)
                    .padding()

                Spacer()
            }
        }
        .padding()
    }
}
    

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [.orange, .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        SettingsPageView(viewModel: MainViewModel(), showSettings: .constant(true))
    }
}
