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
            LinearGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .feed), .black, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            if (viewModel.selectedNews != nil) {
                NewsDetailView(news: $viewModel.selectedNews)
            }
            
            ScrollView {
                LazyVStack {
                    NewsCarousel(viewModel: viewModel)
                    
                    CreditFeedView(viewModel: viewModel)
                    
                    Spacer()
                }
                .padding(.top, 90)
            }
            .refreshable {
                withAnimation {
                    viewModel.getNews()
                }
            }
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
