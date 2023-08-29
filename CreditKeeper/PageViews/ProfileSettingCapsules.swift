//
//  ProfileSettingCapsules.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/28/23.
//

import SwiftUI

struct ProfileSettingCapsules: View {
    var body: some View {
        Group {
            HStack {
                Button (action: {
                    
                }, label: {
                    ZStack {
                        Capsule()
                            .foregroundStyle(Color("uiCapsuleOrange"))
                            .frame(width: 100, height: 30)
                        Text("Edit Profile")
                            .foregroundStyle(.white)
                    }
                })
                
                Spacer()
                
                Button (action: {
                    
                }, label: {
                    ZStack {
                        Capsule()
                            .foregroundStyle(Color("uiCapsuleOrange"))
                            .frame(width: 100, height: 30)
                        Text("Settings")
                            .foregroundStyle(.white)
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    ProfileSettingCapsules()
}
