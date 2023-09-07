//
//  CreditCapsuleview.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/7/23.
//

import SwiftUI

struct CreditCapsuleview: View {
    @State var rider : String
    @State var type : String
    @State var ride : String
    @State var rideID : String
    @State var likes : Int
    @State var likeThisOne = false
    
    var body: some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 4)
                    .frame(width: nil, height: 40)
            
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .frame(width: nil, height: 40)
                
                HStack {
                    Button(action: {
                        playHaptic()
                        
                    }, label: {
                        Image(systemName: "person.circle.fill")
                            .foregroundStyle(.white, .orange)
                            .font(.system(size: 30))
                    })
                    
                    
                    Text(rider + " " + type + " " + ride)
                        .font(.system(size: 15))
                        .foregroundStyle(.white)
                        .padding()
                    
                    Button(action: {
                        playHaptic()
                        
                    }, label: {
                        ZStack {
                            Circle()
                                .foregroundStyle(.red)
                                .frame(width: 30, height: 30)
                            
                            Image("rollercoaster")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    })
                }
            }
            .padding(.leading, 6)
            .padding(.trailing, 20)
            .padding(.bottom)
            
            HStack {
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
                    }
                }, label: {
                    ZStack {
                        Capsule()
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 20)
                        
                        HStack {
                            Image(systemName: likeThisOne ? "hand.thumbsup.fill" : "hand.thumbsup")
                                .foregroundStyle(.blue)
                                .font(.system(size: 15))
                            
                            Text(String(likes))
                                .foregroundStyle(.black)
                                .font(.system(size: 15))
                        }
                        .frame(width: 60, height: 20)
                    }
                })
            }
            .offset(x: -10, y: 20)
        }
    }
}

#Preview {
    CreditCapsuleview(rider: "Nick", type: "claimed", ride: "Banshee", rideID: "", likes: 5)
}
