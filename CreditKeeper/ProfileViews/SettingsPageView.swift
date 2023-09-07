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
                        .padding(.leading)
                    
                    Spacer()
                }
                
                ScrollView {
                    ZStack {
                        SettingsCapsuleView(text: "Account:")
                        
                        HStack{
                            Spacer()
                            
                            Button (action: {
                                playHaptic()
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
                    HStack {
                        Button(action: {
                            playHaptic()
                            withAnimation {
                                showSettings = false
                            }
                        }, label: {
                            HStack {
                                Image(systemName: "arrow.left")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 30))
                                
                                Text("Back")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 20))
                            }
                        })
                        
                        Spacer()
                    }
                    .padding(.leading)
                    
                    Button (action: {
                        playHaptic()
                    }, label: {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                    })
                    .padding(.trailing)
                    
                    Spacer()
                }
            }
            .padding(.top, 50)
            .padding(.bottom, 30)
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
    SettingsPageView(viewModel: MainViewModel(), showSettings: .constant(true))
}
