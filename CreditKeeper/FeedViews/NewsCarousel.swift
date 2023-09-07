//
//  NewsCarousel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct NewsCarousel: View {
    @StateObject var viewModel : MainViewModel
    @State var index = 1
    var body: some View {
        VStack {
            if (viewModel.news.count == 0) {
                ZStack {
                    Rectangle()
                        .cornerRadius(20)
                        .frame(width: nil, height: 130)
                        .padding(.horizontal)
                        .foregroundStyle(.uiCapsuleBlue)
                        .shadow(radius: 10)
                    HStack {
                        Image(systemName: "newspaper")
                            .font(.system(size: 40))
                        
                        Text("A puzzling lack of news...\nOh well, keep riding!")
                            .bold()
                            .multilineTextAlignment(.center)
                            .font(.system(size: 15))
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.horizontal, 30)
                }
            } else {
                TabView() {
                    ForEach((viewModel.news), id: \.id) { news in
                        Button (action: {
                            withAnimation {
                                playHaptic()
                                viewModel.selectedNews = news
                            }
                        }, label: {
                            ZStack {
                                Rectangle()
                                    .cornerRadius(20)
                                    .frame(width: nil, height: 130)
                                    .padding(.horizontal)
                                    .foregroundStyle(.uiCapsuleBlue)
                                    .shadow(radius: 10)
                                
                                HStack {
                                    Image(systemName: news.symbol)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 40))
                                        .padding(.leading)
                                    
                                    Text(news.displayName)
                                        .bold()
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.white)
                                        .font(.system(size: 20))
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.white)
                                        .padding(.trailing)
                                        .font(.system(size: 10))
                                }
                            }
                        })
                    }
                }
                .tabViewStyle(.page)
            }
        }
        .frame(width: nil, height: 200)
    }
}

#Preview {
    NewsCarousel(viewModel: MainViewModel())
}
