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
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.thinMaterial)
            
            ScrollView {
                VStack {
                    
                    HStack {
                        Text(ride?.name ?? " ")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .shadow(color: .black, radius: 3)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(park?.name ?? "Unknown Park")
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Gauge(value: ride?.speed ?? 0, in: 0...120, label: {
                            Text("Speed")
                                .bold()
                                .foregroundStyle(.white)
                        })
                        .gaugeStyle(.accessoryCircularCapacity)
                        .tint(.red)
                        .scaleEffect(1.2)
                        .padding(.vertical)
                        
                        Text(String(Int(ride?.speed ?? 0)) + "\nmph")
                            .padding(.leading, 4)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.trailing)
                            .multilineTextAlignment(.center)
                        
                        ZStack {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .foregroundStyle(.purple)
                                .font(.system(size: 60))
                            
                            Text(String(ride?.inversions ?? 0))
                                .bold()
                                .foregroundStyle(.white)
                        }
                        
                        Text("Inversions")
                            .padding(.leading, 4)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.trailing)
                        
                    }

                    HStack {
                        VStack {
                            Text(String(Int(ride?.height ?? 0)) + "ft tall")
                                .bold()
                                .foregroundStyle(.white)
                            
                            
                            Text(String(Int(ride?.length ?? 0)) + "ft long")
                                .bold()
                                .foregroundStyle(.white)
                        }
                        
                        VStack (alignment: .leading) {
                            Gauge(value: ride?.height ?? 0, in: 0...456, label: {})
                                .shadow(radius: 2)
                                .tint(.green)
                            
                            Gauge(value: ride?.length ?? 0, in: 0...8133, label: {})
                                .shadow(radius: 2)
                                .tint(.blue)
                        }
                        
                        
                        
                    }
                    .tint(.green)
                    
                    
                    // MORE!
                    
                    
                }
                .padding(.top, 50)
                .padding(.horizontal)
            }
            
            VStack {
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
        }
        .transition(.move(edge: .trailing))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ZStack {
        LinearGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .ride), .black, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
        
        RideDetailView(viewModel: MainViewModel(), ride: .constant(Ride(id: "", name: "Millennium Force", parkID: "", legacy: false, description: "3 trains with 9 cars per train. Riders are arranged 2 across in 2 rows for a total of 36 riders per train.", opening: Date(), closing: Date(), thrillLevel: "Extreme", type: "Sit Down", height: 310.0, length: 6595.0, speed: 93.0, inversions: 0, manufacturer: "Intamin Amusement Rides", gforce: 0, previousRideID: "", averageRating: 4.3, lastEdited: Date())))
    }
}
