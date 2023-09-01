//
//  RidePageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

struct RidePageView: View {
    @StateObject var viewModel : MainViewModel
    @State private var searchText = ""
    @State private var atAPark = true
    
    var body: some View {
        VStack {
            ScrollView {
                Text("Looks like you're at King's Island...\nHere ya go! Or start typing.")
                    .bold()
                    .foregroundStyle(.white)
                    .padding(.top, 70)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                
                ForEach(1...15, id: \.self) { i in
                    RideCapsuleView()
                }
            }
            .padding(.bottom, -10)
            
            Spacer()
            
            Rectangle()
                .frame(width: nil, height: 2)
                .foregroundStyle(.white)
                .padding(.horizontal, -10)
            
            Spacer()
                
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 120)
    }
}

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        RidePageView(viewModel: MainViewModel())
    }
}



