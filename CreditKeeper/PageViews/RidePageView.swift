//
//  RidePageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

struct RidePageView: View {
    @ObservedObject var viewModel : MainViewModel
    @State private var searchText = ""
    @State private var atAPark = true
    
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .ride), .black]), center: .center, startRadius: 2, endRadius: 650)
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView {
                        Text("Looks like you're at Cedar Point...\nHere ya go! Or start typing.")
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.top, 70)
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                        
                        ForEach(viewModel.rides, id: \.self) { ride in
                            RideCapsuleView(ride: ride, viewModel: viewModel)
                        }
                        .padding(.bottom, -10)
                        
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 120)
                }
                
                if (viewModel.selectedRide != nil) {
                    RideDetailView(viewModel: viewModel, ride: $viewModel.selectedRide)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

#Preview {
    RidePageView(viewModel: MainViewModel())
}



