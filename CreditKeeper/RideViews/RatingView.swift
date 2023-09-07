//
//  RatingView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/4/23.
//

import SwiftUI

struct RatingView: View {
    @ObservedObject var viewModel : MainViewModel
    @Binding var ride: Ride
    @Binding var showRating : Bool
    @State var showCongrats = false
    @State private var rating: Int = 0
 
    var body: some View {
        HStack {
            if (showCongrats) {
                Text("Congrats!")
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
                                viewModel.submitRating(rating: rating, ride: ride.id, { success in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation {
                                            showCongrats = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                            withAnimation {
                                                showCongrats = false
                                                showRating = false
                                            }
                                        }
                                    }
                                })
                            }
                        }
                }
            }
            if (!showCongrats) {
                Button (action: {
                    withAnimation {
                        showRating = false
                    }
                }, label: {
                    Text("Skip")
                        .padding(.leading)
                        .foregroundStyle(.white)
                })
            }
        }
        
        .transition(.opacity)
    }
}

#Preview {
    RatingView(viewModel: MainViewModel(), ride: .constant(Ride(id: "", name: "", parkID: "", manufacturer: "", opening: Date(), legacy: false, height: 0.0, length: 0.0, inversions: 2, thrillLevel: "", type: "", speed: 0.0, description: "")), showRating: .constant(true))
}
