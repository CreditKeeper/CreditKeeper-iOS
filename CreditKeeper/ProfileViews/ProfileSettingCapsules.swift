//
//  ProfileSettingCapsules.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/28/23.
//

import SwiftUI

struct ProfileSettingCapsules: View {
    @Binding var showSettings : Bool
    @Binding var editProflie : Bool
    
    var body: some View {
        Group {
            HStack {
                Button (action: {
                    withAnimation {
                        editProflie = true
                    }
                }, label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 30)
                        
                        Image(systemName: "pencil.circle.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.orange)
                    }
                })
                
                Button (action: {
                    withAnimation {
                        showSettings = true
                    }
                }, label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 30)
                        
                        Image(systemName: "gear.circle.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.orange)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    ProfileSettingCapsules(showSettings: .constant(false), editProflie: .constant(false))
}
