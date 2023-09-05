//
//  AuthView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/5/23.
//

import SwiftUI

struct AuthView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel : MainViewModel
    @Binding var registeringUser : Bool
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .profile), .black]), center: .center, startRadius: 2, endRadius: 650)
                .ignoresSafeArea()
            
            if (registeringUser) {
                RegisterView(viewModel: viewModel, registeringUser: $registeringUser)
                    .transition(.move(edge: .trailing))
            } else {
                LoginView(viewModel: viewModel, registeringUser: $registeringUser)
                    .transition(.move(edge: .leading))
            }
        }
    }
}

#Preview {
    AuthView(viewModel: MainViewModel(), registeringUser: .constant(false))
}
