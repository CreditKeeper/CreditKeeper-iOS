//
//  MapPageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct MapPageView: View {
    var body: some View {
        ZStack {
            Color("uiBackground")
                .ignoresSafeArea()
            
            Text("Map Page")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    MapPageView()
}
