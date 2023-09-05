//
//  ClaimButtonView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/4/23.
//

import SwiftUI

struct ClaimButtonView: View {
    @ObservedObject var viewModel : MainViewModel
    @Binding var ride : Ride
    @Binding var hasCredit : Bool
    @Binding var showReview : Bool
    @State private var networkProgress = false
    
    var body: some View {
        Button (action: {
            playHaptic()
            if (hasCredit) {
                Task.init {
                    withAnimation {
                        networkProgress = true
                        viewModel.claimCredit(ride: ride.id, { created in
                            hasCredit = created
                            playHaptic()
                            networkProgress = false
                            
                        })
                    }
                }
            }
            else {
                Task.init {
                    withAnimation {
                        networkProgress = true
                        viewModel.claimCredit(ride: ride.id, { created in
                            hasCredit = created
                            
                            if (!ride.legacy) {
                                showReview = true
                            }
                            playHaptic()
                            networkProgress = false
                        })
                    }
                }
            }
        }, label: {
            if (!hasCredit) {
                ZStack {
                    Capsule()
                        .frame(width: 80, height: 40)
                        .foregroundStyle(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(hasCredit ? Color("uiCapsuleGreen") : Color.white, lineWidth: 2)
                        )
                    if (networkProgress) {
                        ProgressView()
                            .progressViewStyle(.circular)
                    } else {
                        Text("Claim")
                            .fontWeight(.bold)
                            .foregroundStyle(ride.legacy ? Color("") : Color("uiCapsuleRed"))
                            .transition(.opacity)
                    }
                    
                }
            } else {
                if (ride.legacy) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white)
                        .padding()
                } else {
                    ZStack {
                        Capsule()
                            .frame(width: 80, height: 40)
                            .foregroundStyle(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.green, lineWidth: 2)
                            )
                        if (networkProgress) {
                            ProgressView()
                                .progressViewStyle(.circular)
                        } else {
                            Text("Ride")
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                                .transition(.opacity)
                        }
                    }
                }
            }
        })
        .disabled(networkProgress)
    }
}

#Preview {
    ClaimButtonView(viewModel: MainViewModel(), ride: .constant(Ride(id: "", name: "", parkID: "", manufacturer: "", opening: Date(), legacy: false, height: 0.0, length: 0.0, inversions: 2, thrillLevel: "", type: "", speed: 0.0, description: "")), hasCredit: .constant(false), showReview: .constant(false))
}
