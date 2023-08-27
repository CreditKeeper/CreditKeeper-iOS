//
//  TabBarView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case feed
    case ride
    case map
    case profile
}

struct TabBarView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var offset = CGSize.zero
    @Binding var selectedTab : Tab
    
    private var tabColor: Color {
        switch selectedTab {
        case .feed:
            return .green
        case .ride:
            return .red
        case .map:
            return .blue
        case .profile:
            return .orange
        }
    }
    
    var body: some View {

        HStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                
                Spacer()
                
                Button (action: {
                    withAnimation(.easeIn(duration: 0.1)) {
                        selectedTab=tab
                    }
                }, label: {
                    switch (tab) {
                    case .feed :
                        Image(systemName: "list.bullet.below.rectangle")
                            .shadow(radius: 10)
                    case .ride :
                        Image(systemName: "circle.dotted.circle")
                            .shadow(radius: 10)
                    case .map :
                        Image(systemName: "map")
                            .shadow(radius: 10)
                    case .profile :
                        Image(systemName: "person.crop.circle")
                            .shadow(radius: 10)
                    }
                })
                .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                .foregroundColor(selectedTab == tab ? tabColor : (colorScheme == .dark ? .white : .black))
                .font(.system(size: 22))
                
                Spacer()
                
            }
        }
        .frame(width: nil, height: 50)
        .background(Color("uiNavPrimary"))
        .cornerRadius(25)
        .padding(.horizontal, 10)
        .shadow(radius: 5, x: 6, y: 5)
        .offset(x: offset.width * 0.08, y: offset.height * 0.08)
        .gesture(dragBar)
    }
    
    var dragBar : some Gesture {
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                
            }
            .onEnded { _ in
                withAnimation (.bouncy) {
                    offset = .zero
                }
            }
    }
}

#Preview {
    ZStack {
        Color.black
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        VStack {
            Spacer()
            TabBarView(selectedTab: .constant(.feed))
        }
    }
}
