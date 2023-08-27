//
//  ProfilePageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

struct ProfilePageView: View {
    var body: some View {
        ZStack {
            Color("uiBackground")
                .ignoresSafeArea()
            
            Text("Profile Page")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ProfilePageView()
}
