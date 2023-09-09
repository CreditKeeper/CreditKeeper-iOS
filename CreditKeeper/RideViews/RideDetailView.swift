//
//  RideDetailView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/3/23.
//

import SwiftUI

struct RideDetailView: View {
    @ObservedObject var viewModel : MainViewModel
    @Binding var ride : Ride?
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.thinMaterial)
            
            ScrollView {
                VStack {
                    
                    HStack {
                        Text(ride?.name ?? " ")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    .padding()
                    
                    Spacer()
                    
                    // all sorts of stuff, including a second place to claim / ride
                    
                }
                .padding(.top, 50)
            }
            
            VStack {
                Group {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                viewModel.selectedRide = nil
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
                    .padding(.horizontal)
                }
            }.padding(.bottom, 40)
        }
        .transition(.move(edge: .trailing))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    RideDetailView(viewModel: MainViewModel(), ride: .constant(Ride(id: "", name: "BigRide", parkID: "", legacy: false, description: "This is a big ride.", opening: Date(), closing: Date(), thrillLevel: "Thrilling", type: "StandUp", height: 100.0, length: 101.0, speed: 102.0, inversions: 2, manufacturer: "NickInc", gforce: 10.0, previousRideID: "", averageRating: 4.3, lastEdited: Date())))
}
