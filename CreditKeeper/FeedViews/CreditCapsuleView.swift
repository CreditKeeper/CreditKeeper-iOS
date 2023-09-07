//
//  CreditCapsuleview.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/7/23.
//

import SwiftUI

struct CreditCapsuleView: View {
    @State var rider : String
    @State var type : String
    @State var ride : String
    @State var rideID : String
    @State var likes : Int
    @State var likeThisOne = false
    
    var body: some View {
        ZStack {
            Group {
                Button(action: {
                    playHaptic()
                    withAnimation {
                        // change selected tab
                        // change selected ride
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.ultraThinMaterial, lineWidth: 7)
                            .frame(width: nil, height: 50)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color("uiCapsuleBlue"))
                            .frame(width: nil, height: 50)
                        
                        HStack {
                            Spacer()
                            
                            Text(rider + " " + type + " " + ride)
                                .font(.system(size: 15))
                                .foregroundStyle(.white)
                                .padding()
                                .multilineTextAlignment(.leading)
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.white)
                                .font(.system(size: 10))
                            
                            Spacer()
                        }
                        .padding(.trailing)
                    }
                })
            }
            
            Group {
                HStack {
                    Button(action: {
                        playHaptic()
                        withAnimation {
                            // show user's profile
                        }
                        
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.white, lineWidth: 2)
                                .foregroundStyle(.orange)
                                .frame(width: 35, height: 50)
                            
                            Image(systemName: "person.circle.fill")
                                .foregroundStyle(.white, .orange)
                                .font(.system(size: 25))
                        }
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        playHaptic()
                        withAnimation {
                            likeThisOne.toggle()
                            if likeThisOne {
                                likes+=1
                            } else {
                                likes-=1
                            }
                            // actually send the like
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.thinMaterial)
                                .frame(width: 60, height: 50)
                            
                            HStack {
                                Image(systemName: likeThisOne ? "hand.thumbsup.fill" : "hand.thumbsup")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15))
                                
                                Text(String(likes))
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15))
                            }
                        }
                    })
                }
            }
        }
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .feed), .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        VStack {
            CreditCapsuleView(rider: "Nick", type: "claimed", ride: "Banshee", rideID: "", likes: 5)
            CreditCapsuleView(rider: "Nick", type: "claimed", ride: "Banshee", rideID: "", likes: 5)
        }
    }
}
