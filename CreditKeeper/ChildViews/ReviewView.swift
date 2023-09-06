//
//  ReviewView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/4/23.
//

import SwiftUI

struct ReviewView: View {
    @ObservedObject var viewModel : MainViewModel
    @Binding var ride: Ride
    @Binding var showReview : Bool
    @State var showThanks = false
    @State private var rating: Int = 0
    
    var body: some View {
        HStack {
            if (showThanks) {
                Text("Thank you!")
                    .bold()
                    .foregroundStyle(.white)
                    .font(.title2)
            } else {
                ForEach(1..<6) { index in
                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(index <= rating ? Color("uiCapsuleYellow") : .white)
                        .onTapGesture {
                            withAnimation {
                                rating = index
                                playHaptic()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        showThanks = true
                                    }
                                    
                                    
                                    // submit ride rating
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                        withAnimation {
                                            showThanks = false
                                            showReview = false
                                        }
                                        
                                    }
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    ReviewView(viewModel: MainViewModel(), ride: .constant(Ride(id: "", name: "", parkID: "", manufacturer: "", opening: Date(), legacy: false, height: 0.0, length: 0.0, inversions: 2, thrillLevel: "", type: "", speed: 0.0, description: "")), showReview: .constant(true))
}
