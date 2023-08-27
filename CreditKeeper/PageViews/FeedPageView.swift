//
//  FeedPageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

struct FeedPageView: View {
    var body: some View {
        ZStack {
            Color("uiBackground")
                .ignoresSafeArea()
            
            Text("Feed Page")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    FeedPageView()
}
