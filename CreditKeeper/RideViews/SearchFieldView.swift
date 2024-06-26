//
//  SearchFieldView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct SearchFieldView: View, KeyboardReadable {
    @StateObject var viewModel : MainViewModel
    @State private var showFilter = true
    @Binding var searchText : String
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                    print("Is keyboard visible? ", newIsKeyboardVisible)
                    viewModel.keyboardVisible = newIsKeyboardVisible
                }
                .onSubmit {
                    withAnimation (.linear) {
                        showFilter = true
                        if (searchText == "") {
                            viewModel.getSomeRides()
                        } else {
                            viewModel.rideSearch(rideName: searchText)
                        }
                    }
                }
                .padding(.vertical)
                .onTapGesture {
                    playHaptic()
                    withAnimation (.linear) {
                        showFilter = false
                    }
                }
                
            
            if (showFilter) {
                Button(action: {
                    playHaptic()
                }, label: {
                    ZStack {
                        Circle()
                            .foregroundStyle(.ultraThinMaterial)
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
    SearchFieldView(viewModel: MainViewModel(), searchText: .constant("Search"))
}
