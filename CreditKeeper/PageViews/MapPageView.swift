//
//  MapPageView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI
import MapKit

struct MapPageView: View {
    @StateObject var viewModel : MainViewModel
    @State private var userTrackingMode : MapUserTrackingMode = .none
    
    var body: some View {
        ZStack {
            MapView(viewModel: viewModel, userTrackingMode: $userTrackingMode)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                HStack {
                    Button (action: {
                        if (userTrackingMode == .follow) {
                            userTrackingMode = .none
                        } else {
                            userTrackingMode = .follow
                        }
                    }, label: {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(.ultraThinMaterial)
                                
                            Image(systemName: userTrackingMode == .follow ? "location.fill" : "location")
                                .font(.system(size: 30))
                                
                        }
                    })
                    
                    Spacer()
                }
                .padding()
                
                if (viewModel.selectedPark != nil) {
                    // show park popup
                }
            }
        }
    }
}

#Preview {
    MapPageView(viewModel: MainViewModel())
}
