//
//  NewsCarousel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct NewsCarousel: View {
    @ObservedObject var viewModel : MainViewModel
    @State private var index = 1
    var body: some View {
        VStack {
            TabView(selection: $index) {
                ForEach((0..<3), id: \.self) { index in
                    Rectangle()
                        .cornerRadius(20)
                        .frame(width: nil, height: 130)
                        .padding(.horizontal)
                        .foregroundStyle(.uiCapsuleBlue)
                        .shadow(radius: 10)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
        .frame(width: nil, height: 200)
    }
}

#Preview {
    NewsCarousel(viewModel: MainViewModel())
}
