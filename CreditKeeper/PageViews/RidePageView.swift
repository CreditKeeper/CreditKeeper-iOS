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
    @State private var showRideSheet = false
    
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
                                RideCapsuleView(ride: ride, viewModel: viewModel, showRideSheet: $showRideSheet)
                        }
                        .padding(.bottom, -10)
                        
                    }
                    .padding(.horizontal, 10)
                    .padding(.bottom, 120)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [.red, .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        RidePageView(viewModel: MainViewModel())
    }
}



