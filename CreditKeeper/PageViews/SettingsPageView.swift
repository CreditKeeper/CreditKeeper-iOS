//
//  SettingsPageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct SettingsPageView: View {
    var body: some View {
        ZStack {
            Color("uiBackground")
                .ignoresSafeArea()
            
            Text("Settings Page")
                .foregroundColor(.white)
        }
        
    }
}

#Preview {
    SettingsPageView()
}
