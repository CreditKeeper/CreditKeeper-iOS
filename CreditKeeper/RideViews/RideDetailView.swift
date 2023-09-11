//
//  RideDetailView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/3/23.
//

import SwiftUI

struct RideDetailView: View {
    @ObservedObject var viewModel : MainViewModel
    @Binding var ride : Ride?
    @State var park : Park?
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.thinMaterial)
            
            VStack {
                HStack {
                    Text(ride?.name ?? " ")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .shadow(color: .black, radius: 3)
                        .padding(.horizontal)
                    
                    
                    Spacer()
                }
                
                HStack {
                    Button(action: {
                        // take me to the park view
                        
                        
                        
                    }, label: {
                        Text(park?.name ?? "Unknown Park")
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                    })
                    
                    Spacer()
                }
                
                TabView {
                    
                    Text("Queue time, top 5 insertion button, description?, claim / ride button")
                        .tabItem {
                            Image(systemName: "info.circle")
                        }
                    
                    RideStatsView(ride: $ride)
                        .tabItem {
                            Image(systemName: "gauge.with.dots.needle.67percent")
                        }
                    
                    Text("Photos and camera button to submit a new photo")
                        .tabItem {
                            Image(systemName: "camera")
                        }
                    
                    
                }
                .tabViewStyle(.page)
            
                Group {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                viewModel.selectedRide = nil
                            }
                        }, label: {
                            HStack {
                                Image(systemName: "arrow.left")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 30))
                                
                                Text("Back")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 20))
                            }
                        })
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }.padding(.bottom, 40)
            .transition(.move(edge: .trailing))
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .ride), .black, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
        
        RideDetailView(viewModel: MainViewModel(), ride: .constant(Ride(id: "", name: "Millennium Force", parkID: "", legacy: false, description: "3 trains with 9 cars per train. Riders are arranged 2 across in 2 rows for a total of 36 riders per train.", opening: Date(), closing: Date(), thrillLevel: "Extreme", type: "Sit Down", height: 310.0, length: 6595.0, speed: 93.0, inversions: 0, manufacturer: "Intamin Amusement Rides", gforce: 0, duration: 2.45, capacity: 1600, previousRideID: "", averageRating: 4.3, lastEdited: Date())))
    }
}
