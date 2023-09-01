//
//  HeaderView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

struct HeaderView: View {
    @Binding var selectedTab : Tab
    
    var body: some View {
        VStack () {
            HStack {
                Text(selectedTab.getName(tab: selectedTab))
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                                
                Spacer()
                
                Button(action: {
                   
                }, label: {
                   Image(systemName: "cloud.sun")
                        .foregroundColor(.white)
                })
            }
            .padding(.bottom, 10)
        }
        .padding(.horizontal)
        .background(.thinMaterial)
        .environment(\.colorScheme, .dark)
        .shadow(radius: 20)
    }
}

#Preview {
    HeaderView(selectedTab: .constant(.feed))
}


extension Tab {
    func getName(tab : Tab) -> String {
        switch (tab) {
        case .feed :
            return "CreditKeeper"
            
        case .ride :
            return "Rides"
            
        case .map :
            return "Map"
            
        case .profile :
            return "You"
        }
    }
}
