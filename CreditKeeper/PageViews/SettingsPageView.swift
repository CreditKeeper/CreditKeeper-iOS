//
//  SettingsPageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct SettingsPageView: View {
    var body: some View {
        Text("Settings Page")
            .foregroundStyle(.white)
    }
}

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        SettingsPageView()
    }
}
