//
//  CreditFeedView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/3/23.
//

import SwiftUI

struct CreditFeedView: View {
    @ObservedObject var viewModel: MainViewModel
    var body: some View {
        VStack {
            ForEach((1...10), id: \.self) { _ in
                CreditCapsuleview(rider: "Nick", type: "claimed", ride: "Banshee", rideID: "", likes: 10)
            }
            
            Spacer(minLength: 80)
        }
    }
}

#Preview {
    CreditFeedView(viewModel: MainViewModel())
}
