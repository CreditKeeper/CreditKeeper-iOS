//
//  FeedPageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

struct FeedPageView: View {
    var body: some View {
        ScrollView {
            VStack {
                NewsCarousel()
                
                Spacer()
            }
            .padding(.top, 70)
        }
    }
}

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        FeedPageView()
    }
}
