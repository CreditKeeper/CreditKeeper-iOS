//
//  RidePageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

struct RidePageView: View {
    @State private var searchText = ""
    @State private var atAPark = true
    var body: some View {
        VStack {
            ScrollView {
                Text("Looks like you're at King's Island...\nHere ya go! Or start typing.")
                    .bold()
                    .padding(.top, 70)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                
                ForEach(1...15, id: \.self) { i in
                    RideCapsuleView()
                }
            }
            
            
            
            Spacer()
            
            SearchFieldView(searchText: $searchText)
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 60)
    }
}

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        RidePageView()
    }
}



