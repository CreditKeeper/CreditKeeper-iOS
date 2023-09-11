//
//  RideStatsView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/10/23.
//

import SwiftUI

struct RideStatsView: View {
    @Binding var ride : Ride?
    var body: some View {
        VStack {
            HStack {
                Gauge(value: ride?.length ?? 0, in: 0...8133, label: {})
                    .shadow(radius: 2)
                    .tint(.blue)
                
                Text(String(Int(ride?.length ?? 0)) + " feet long")
                    .foregroundStyle(.white)
                    .bold()
            }
            .padding()
            
            HStack {
                VStack {
                    Gauge(value: ride?.height ?? 0, in: 0...456, label: {})
                        .shadow(radius: 2)
                        .tint(.green)
                        .rotationEffect(Angle(degrees: -90))
                        .frame(width: 150, height: 100)
                    
                    Text(String(Int(ride?.height ?? 0)) + " feet tall")
                        .foregroundStyle(.white)
                        .bold()
                        .padding()
                }
                
                VStack {
                    Group {
                        HStack {
                            Gauge(value: ride?.speed ?? 0, in: 0...120, label: {
                                Text(String(Int(ride?.speed ?? 0)) + "\nmph")
                                    .bold()
                                    .foregroundStyle(.white)
                                    .multilineTextAlignment(.center)
                            })
                            .gaugeStyle(.accessoryCircularCapacity)
                            .tint(.red)
                            .scaleEffect(1.2)
                        
                            
                            Text("Top Speed")
                                .bold()
                                .foregroundStyle(.white)
                                .padding(.leading, 9)
                            
                            Spacer()
                        }
                        
                        HStack {
                            ZStack {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .foregroundStyle(.purple)
                                    .font(.system(size: 65))
                                
                                
                                Text(ride?.inversions ?? 0 > 0 ? String(ride?.inversions ?? 0) : "None")
                                    .bold()
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15))
                            }
                            
                            Text("Inversions")
                                .bold()
                                .foregroundStyle(.white)
                                .padding(.leading, -4)
                            
                            Spacer()
                        }
                        .padding(.leading, -17)
                    }
                }
                .padding(.bottom)
            }
            .padding()
            
            HStack {
                Image(systemName: "clock")
                    .foregroundStyle(.white)
                .font(.system(size: 40))
                .frame(width: 90)
                
                Text("Duration: " + String(ride?.duration ?? 1.00) + " minutes")
                    .foregroundStyle(.white)
                    .bold()
                
                Spacer()
            }
            .padding(.leading)
            .padding(.bottom)
            
            HStack {
                Image(systemName: "person.3")
                    .foregroundStyle(.white, .orange)
                .font(.system(size: 40))
                .frame(width: 90)
                
                Text("Capacity: " + String(ride?.capacity ?? 1) + " per hour")
                    .foregroundStyle(.white)
                    .bold()
                
                Spacer()
            }
            .padding(.leading)
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .ride), .black, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
        
        Rectangle()
            .ignoresSafeArea()
            .foregroundStyle(.thinMaterial)
        
        RideStatsView(ride: .constant(Ride(id: "", name: "Millennium Force", parkID: "", legacy: false, description: "3 trains with 9 cars per train. Riders are arranged 2 across in 2 rows for a total of 36 riders per train.", opening: Date(), closing: Date(), thrillLevel: "Extreme", type: "Sit Down", height: 310.0, length: 6595.0, speed: 93.0, inversions: 0, manufacturer: "Intamin Amusement Rides", gforce: 0, duration: 2.46, capacity: 1600, previousRideID: "", averageRating: 4.3, lastEdited: Date())))
    }
}
