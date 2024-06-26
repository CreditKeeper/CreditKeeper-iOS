//
//  TabBarView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/26/23.
//

import SwiftUI
import Combine

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
    @Binding var keyboardVisible : Bool
    
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
            
            if (!keyboardVisible) {
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
                .background(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
                .cornerRadius(25)
                .padding(.horizontal, 10)
                .shadow(radius: 5, x: 6, y: 5)
                .offset(x: viewModel.tabBarGesture ? offset.width * 0.08 : 0, y: viewModel.tabBarGesture ? offset.height * 0.08 : 0)
            }
                
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

protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        VStack {
            Spacer()
            TabBarView(viewModel: MainViewModel(), selectedTab: .constant(.ride), searchText: .constant(""), keyboardVisible: .constant(false))
        }
    }
}
