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
        Text("Yeppers")
    }
}

#Preview {
    CreditFeedView(viewModel: MainViewModel())
}
