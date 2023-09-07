//
//  MapView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/3/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var viewModel : MainViewModel
    @Binding var userTrackingMode : MapUserTrackingMode
        
    var body: some View {
        Map(coordinateRegion: .constant(viewModel.region), interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode)
            .ignoresSafeArea()
    }
}

#Preview {
    MapView(viewModel: MainViewModel(), userTrackingMode: .constant(.none))
}
