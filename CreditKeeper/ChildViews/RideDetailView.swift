//
//  RideDetailView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/3/23.
//

import SwiftUI

struct RideDetailView: View {
    @Binding var ride : Ride?
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .ride), .black]), center: .center, startRadius: 2, endRadius: 650)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Text(ride?.name ?? "")
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
    }
}

#Preview {
    RideDetailView(ride: .constant(Ride(id: "", name: "A ride", parkID: "esdfsefsfsdfs", manufacturer: "Nick Inc", opening: Date(), legacy: false, height: 10.2, length: 12.2, inversions: 2, thrillLevel: "Thrilling", type: "Stand Up", speed: 200.3, description: "It's a big one")))
}
