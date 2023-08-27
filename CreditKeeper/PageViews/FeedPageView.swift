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
            ScrollView {
                VStack {
                    NewsCarousel()
                    
                    Spacer()
                }
                .padding(.top, 55)
            }
        }
    }
}

#Preview {
    FeedPageView()
}
