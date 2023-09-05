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
            }
        }
        .transition(.move(edge: .trailing))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    RideDetailView(viewModel: MainViewModel(), ride: .constant(Ride(id: "", name: "A ride", parkID: "esdfsefsfsdfs", manufacturer: "Nick Inc", opening: Date(), legacy: false, height: 10.2, length: 12.2, inversions: 2, thrillLevel: "Thrilling", type: "Stand Up", speed: 200.3, description: "It's a big one")))
}
