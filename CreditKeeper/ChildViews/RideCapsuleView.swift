//
//  RideCapsuleView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI
import CoreLocation

struct RideCapsuleView: View {
    @State var ride : Ride
    @State private var park = Park(id: "", name: "Unknown", address: "", city: "", region: "", country: "", owner: "", link: "", phone: "", location: CLLocation())
    @State private var hasCredit = false
    @ObservedObject var viewModel : MainViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: nil, height: 90)
                .cornerRadius(15)
                .foregroundColor(hasCredit ? Color.green : Color("uiCapsuleRed"))
                .shadow(radius: 10)
            
            HStack {
                Group {
                    VStack (alignment: .leading) {
                        Text(ride.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Text(park.name)
                            .font(.callout)
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                }
                
                if (viewModel.loggedIn) {
                    Button (action: {
                        playHaptic()
                        if (hasCredit) {
                            Task.init {
                                withAnimation {
                                    viewModel.claimCredit(ride: ride.id, { created in
                                        hasCredit = created
                                        
                                    })
                                }
                            }
                        }
                        else {
                            Task.init {
                                withAnimation {
                                    viewModel.claimCredit(ride: ride.id, { created in
                                        hasCredit = created
                                        
                                    })
                                }
                            }
                            // Open review
                            
                        }
                    }, label: {
                        ZStack {
                            Capsule()
                                .frame(width: 80, height: 40)
                                .foregroundStyle(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(hasCredit ? Color.green : Color.white, lineWidth: 2)
                                )
                            
                            Text(hasCredit ? "Ride" : "Claim")
                                .fontWeight(.bold)
                                .foregroundStyle(hasCredit ? .green : Color("uiCapsuleRed"))
                                .transition(.opacity)
                            
                        }
                    })
                }
            }
            .padding()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 4)
        .onAppear {
            hasCredit = viewModel.checkCredit(ride: ride.id)
            park = viewModel.parks.first(where: {$0.id == ride.parkID}) ?? park
        }
        .onTapGesture {
            withAnimation {
                viewModel.selectedRide = ride
            }
        }
    }
}

#Preview {
    RideCapsuleView(ride: Ride(id: "", name: "A ride", parkID: "esdfsefsfsdfs", manufacturer: "Nick Inc", opening: Date(), legacy: false, height: 10.2, length: 12.2, inversions: 2, thrillLevel: "Thrilling", type: "Stand Up", speed: 200.3, description: "It's a big one"), viewModel: MainViewModel())
}
