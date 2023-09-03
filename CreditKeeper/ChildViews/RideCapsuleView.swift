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
    @ObservedObject var viewModel : MainViewModel
    @Binding var showRideSheet : Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: nil, height: 90)
                .cornerRadius(15)
                .foregroundColor(Color("uiCapsuleRed"))
                .shadow(radius: 10)
            
            HStack {
                NavigationLink {
                    RideDetailView(viewModel: viewModel, ride: .constant(viewModel.selectedRide))
                        .onAppear {
                            withAnimation {
                                viewModel.selectedRide = ride
                            }
                        }
                        .onDisappear {
                            withAnimation {
                                viewModel.selectedRide = nil
                            }
                        }
                } label: {
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
                }
                
                Button (action: {
                    
                }, label: {
                    ZStack {
                        Capsule()
                            .frame(width: 80, height: 40)
                            .foregroundStyle(.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            
                        Text("Claim")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            
                    }
                })
            }
            .padding()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 4)
        .onAppear {
            // check if user already has credit, then show ride button if so
            
            park = viewModel.parks.first(where: {$0.id == ride.parkID}) ?? park
        }
        .onTapGesture {
            viewModel.selectedRide = ride
            showRideSheet = true
        }
    }
}

#Preview {
    RideCapsuleView(ride: Ride(id: "", name: "A ride", parkID: "esdfsefsfsdfs", manufacturer: "Nick Inc", opening: Date(), legacy: false, height: 10.2, length: 12.2, inversions: 2, thrillLevel: "Thrilling", type: "Stand Up", speed: 200.3, description: "It's a big one"), viewModel: MainViewModel(), showRideSheet: .constant(false))
}
