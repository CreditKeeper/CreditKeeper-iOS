//
//  SearchFieldView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 8/27/23.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding var searchText : String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search...", text: $searchText)
        }
        .textFieldStyle(OvalTextFieldStyle())
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
