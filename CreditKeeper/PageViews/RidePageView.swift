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
            .padding(.top, 50)
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



