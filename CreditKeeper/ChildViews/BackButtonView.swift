//
//  BackButtonView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/3/23.
//

import SwiftUI

import SwiftUI

struct BackButtonView: View {
    @State var text : String
    @State var color : Color
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .foregroundStyle(color)
                .font(.system(size: 30))
            
            Text(text)
                .bold()
                .foregroundStyle(color)
            
            Spacer()
        }.padding([.leading, .top])
    }
}

#Preview {
    VStack {
        BackButtonView(text: "Back", color: Color.blue)
        BackButtonView(text: "Filters", color: Color.green)
        BackButtonView(text: "Log In", color: Color.orange)
        BackButtonView(text: "Save", color: Color.red)
    }
}
