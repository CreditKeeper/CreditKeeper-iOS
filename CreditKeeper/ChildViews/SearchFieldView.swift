//
//  SearchFieldView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct SearchFieldView: View {
    @State private var showFilter = true
    @Binding var searchText : String
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .onTapGesture {
                    withAnimation (.linear) {
                        showFilter = false
                    }
                }
                .onSubmit {
                    withAnimation (.linear) {
                        showFilter = true
                    }
                }
            
            if (showFilter) {
                Button(action: {
                    
                }, label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(.thinMaterial)
                            .frame(width: 40, height: 40)
                            .padding()
                        
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(.green)
                            .font(.system(size: 20))
                            
                    }
            
                })
            }
        }
        .textFieldStyle(OvalTextFieldStyle())
        .padding(.horizontal, 10)
        .shadow(radius: 10, y: 10)
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .background(.thinMaterial)
            .cornerRadius(20)
            .shadow(radius: 5)
    }
}

#Preview {
    SearchFieldView(searchText: .constant("Search"))
}
