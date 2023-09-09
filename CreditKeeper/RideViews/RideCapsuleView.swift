//
//  RideCapsuleView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI
import CoreLocation
import ConfettiSwiftUI

struct RideCapsuleView: View {
    @State var ride : Ride
    @State private var park = Park(id: "", address: "", city: "", region: "", country: "", name: "", owner: "", link: "", status: "", telephone: "", lastEdited: Date())
    @State private var hasCredit = false
    @State private var rodeToday = false
    @State private var showRating = false
    @State private var confettiCounter = 0
    @ObservedObject var viewModel : MainViewModel
    
    var body: some View {
        ZStack {
            ConfettiCannon(
                counter: $confettiCounter,
                num: 100,
                colors: [.blue, .red, .green, .yellow],
                rainHeight: 300)
            
            Rectangle()
                .frame(width: nil, height: 90)
                .cornerRadius(15)
                .foregroundStyle(ride.legacy ? Color("uiCapsuleYellow") : (hasCredit ? Color("uiCapsuleGreen") :  Color("uiCapsuleRed")))
            
            if (showRating) {
                RatingView(viewModel: viewModel, ride: $ride, showRating: $showRating)
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
                        ClaimButtonView(viewModel: viewModel, ride: $ride, hasCredit: $hasCredit, rodeToday: $rodeToday, showReview: $showRating, confettiCounter: $confettiCounter)
                        
                    } else {
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                            .padding()
                    }
                }
                .padding()
            }
            
            if (hasCredit) {
                VStack {
                    HStack {
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .foregroundStyle(.white)
                                .frame(width: 30)
                            
                            Text("✔")
                        }
                    }
                    .offset(x: 8, y: -35)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 4)
        .onAppear {
            hasCredit = viewModel.checkCredit(ride: ride.id)
            rodeToday = viewModel.rodeToday(ride: ride.id)
            park = viewModel.parks.first(where: {$0.id == ride.parkID}) ?? park
        }
        .onTapGesture {
            playHaptic()
            withAnimation {
                viewModel.selectedRide = ride
            }
        }
    }
}

#Preview {
    RideCapsuleView(ride: Ride(id: "", name: "BigRide", parkID: "", legacy: false, description: "This is a ride", opening: Date(), closing: Date(), thrillLevel: "Thrilling", type: "StandUp", height: 100.0, length: 101.0, speed: 102.0, inversions: 2, manufacturer: "NickInc", gforce: 10.0, previousRideID: "", averageRating: 4.3, lastEdited: Date()), viewModel: MainViewModel())
}
