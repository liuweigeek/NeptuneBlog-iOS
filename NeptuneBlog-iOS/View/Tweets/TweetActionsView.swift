//
//  TweetActionsView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/6/8.
//

import SwiftUI

struct TweetActionsView: View {
    
    let tweet: Tweet
    
    var body: some View {
        
        HStack {
            Button(action: {}, label: {
                Image(systemName: "bubble.left")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
            
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "arrow.2.squarepath")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
            
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "heart")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
            
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "bookmark")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
        }
        .foregroundColor(.gray)
        .padding(.horizontal)
    }
}
