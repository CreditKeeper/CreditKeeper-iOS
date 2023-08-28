//
//  ProfilePageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

struct ProfilePageView: View {
    var body: some View {
        Text("Profile Page")
            .foregroundColor(.white)
    }
}

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        ProfilePageView()
    }
}
