//
//  NewsCarousel.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct NewsCarousel: View {
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .cornerRadius(20)
                    .frame(width: nil, height: 140)
                    .padding(.horizontal)
                    .foregroundStyle(.uiCapsulePrimary)
                    .shadow(radius: 10)
                
                
            }
            
            HStack {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.gray)
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.black)
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.gray)

            }
        }
    }
}

#Preview {
    NewsCarousel()
}
