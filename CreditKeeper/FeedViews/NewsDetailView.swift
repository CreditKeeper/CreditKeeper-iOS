//
//  NewsDetailView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/7/23.
//

import SwiftUI

struct NewsDetailView: View {
    @Binding var news : News?
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .ignoresSafeArea()
            
            VStack {
                Text(news?.header ?? "Unknown")
                    .bold()
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .font(.title)
                
                Spacer()
                
                Image(systemName: news?.symbol ?? "questionmark.square.dashed")
                    .foregroundStyle(getSymbolColor(color: news?.symbolColor ?? "white"))
                    .shadow(radius: 10)
                    .font(.system(size: 50))
                
                Spacer()
                
                Text(news?.body ?? "There seems to have been an issue getting this piece of news. We appologize for the issue. Please exit the news view.")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        playHaptic()
                        news = nil
                    }
                }, label: {
                    ZStack {
                        Capsule()
                            .frame(width: 80, height: 40)
                            .foregroundStyle(.white)
                        
                        Text("Close")
                            .foregroundStyle(.blue)
                    }
                })
            }
            .padding(.horizontal)
            .padding(.top, 120)
            .padding(.bottom, 100)
        }
    }
    
    func getSymbolColor(color: String) -> Color {
        switch (color) {
        case "blue":
            return .blue
        case "red":
            return .red
        case "green":
            return .green
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        case "black":
            return .black
        case "white":
            return .white
        case "pink":
            return .pink
        case "purple":
            return .purple
        case "brown":
            return .brown
        default:
            return .white
        }
    }
}

#Preview {
    NewsDetailView(news: .constant(News(id: "Vua5s0uUKJP6porJMyn1", displayName: "Welcome to CreditKeeper", header: "Welcome to CreditKeeper - Beta", body: "Hey you! We'd like to welcome you to the beta release of CreditKeeper. We envision CreditKeeper as the best place to claim your rollercoaster credits and log your daily rides. Not only will you be able to keep track of parks, coasters, and stats; but your friends will too. We invite you to sign up for an account to start claiming credits today!", symbol: "fireworks", symbolColor: "red")))
}
