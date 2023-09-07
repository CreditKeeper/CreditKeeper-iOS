//
//  FeedPageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

struct FeedPageView: View {
    @StateObject var viewModel : MainViewModel
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .feed), .black]), center: .center, startRadius: 2, endRadius: 650)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    NewsCarousel(viewModel: viewModel)
                    
                    CreditFeedView(viewModel: viewModel)
                    
                    Spacer()
                }
                .padding(.top, 10)
            }
            .refreshable {
                
            }
        .padding(.top, 90)
        }
    }
}

#Preview {
    ZStack {
        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
            .ignoresSafeArea()
        
        FeedPageView(viewModel: MainViewModel())
    }
}
