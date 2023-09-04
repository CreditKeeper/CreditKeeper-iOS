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
    @State private var showReview = false
    @ObservedObject var viewModel : MainViewModel
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: nil, height: 90)
                .cornerRadius(15)
                .foregroundStyle(ride.legacy ? .yellow : (hasCredit ? .green :  Color("uiCapsuleRed")))
            
            if (showReview) {
                ReviewView(viewModel: viewModel, ride: $ride, showReview: $showReview)
                
            } else {
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
                        ClaimButtonView(viewModel: viewModel, ride: $ride, hasCredit: $hasCredit, showReview: $showReview)
                        
                    } else {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
                .padding()
            }
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
