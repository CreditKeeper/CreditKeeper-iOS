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

    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.4808, longitude: -82.6834), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

        var body: some View {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
        }
    
}

#Preview {
    MapPageView(viewModel: MainViewModel())
}
