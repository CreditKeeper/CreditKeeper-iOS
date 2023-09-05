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
    @StateObject var viewModel : MainViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var offset = CGSize.zero
    @Binding var selectedTab : Tab
    @Binding var searchText : String
    
    private var tabColor: Color {
        switch selectedTab {
        case .feed:
            return .blue
        case .ride:
            return .red
        case .map:
            return .green
        case .profile:
            return .orange
        }
    }
    
    var body: some View {
        VStack {
            if (selectedTab == .ride) {
                SearchFieldView(viewModel: viewModel, searchText: $searchText)
                    .environment(\.colorScheme, .dark)
                    .offset(x: offset.width * 0.08, y: offset.height * 0.08)
            }
            
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    
                    Spacer()
                    
                    Button (action: {
                        playHaptic()
                        withAnimation(.easeInOut) {
                            selectedTab = tab
                        }
                    }, label: {
                        switch (tab) {
                        case .feed :
                            Image(systemName: "list.bullet.below.rectangle")
                                .shadow(radius: 10)
                        case .ride :
                            Image("rollercoaster")
                                .resizable()
                                .colorInvert()
                                .colorMultiply(selectedTab == .ride ? .red : .white)
                                .frame(width: 28, height: 30)
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
                    .foregroundStyle(selectedTab == tab ? tabColor : .white)
                    .font(.system(size: 22))
                    
                    Spacer()
                    
                }
            }
            .frame(width: nil, height: 50)
            .background(.thinMaterial)
            .environment(\.colorScheme, .dark)
            .cornerRadius(25)
            .padding(.horizontal, 10)
            .shadow(radius: 5, x: 6, y: 5)
            .offset(x: offset.width * 0.08, y: offset.height * 0.08)
        }
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
            .ignoresSafeArea()
        VStack {
            Spacer()
            TabBarView(viewModel: MainViewModel(), selectedTab: .constant(.ride), searchText: .constant(""))
        }
    }
}
