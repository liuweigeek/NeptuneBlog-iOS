//
//  SearchBar.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/6.
//

import SwiftUI

struct SearchBar: View {
    
    @State var text = ""
    let onCommit: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text, onCommit: {
                onCommit(text)
            })
            .padding(8)
            .padding(.horizontal, 24)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                }
            )
        }
        .padding(.horizontal, 10)
    }
}
