//
//  RideCapsuleView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct RideCapsuleView: View {
    var body: some View {
        ZStack {
            Capsule()
                .frame(width: nil, height: 60)
                .foregroundColor(Color("uiCapsulePrimary"))
                .shadow(radius: 10)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 4)
    }
}

#Preview {
    RideCapsuleView()
}
