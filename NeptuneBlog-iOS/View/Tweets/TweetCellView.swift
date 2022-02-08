//
//  TweetCellView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/5.
//

import SwiftUI
import Kingfisher

struct TweetCellView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let tweet: Tweet
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 12) {
                
                NavigationLink(
                    destination: LazyView(UserProfileView(userId: tweet.author.id!)),
                    label: {
                        if let smallAvatar = tweet.author.smallAvatar {
                            KFImage(URL(string: smallAvatar))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 56, height: 56)
                                .clipShape(Circle())
                                .padding(.leading)
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 56, height: 56)
                                .clipShape(Circle())
                                .foregroundColor(.gray)
                                .padding(.leading)
                        }
                    }
                )
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(tweet.author.name)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        Text("@\(tweet.author.username) •")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        Text(String(tweet.timestampString))
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("...")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.gray)
                        })
                        .padding(.trailing, 2)
                    }
                    
                    Text(tweet.text)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .font(.system(size: 16))
                }
            }
            .padding(.vertical)
            .padding(.trailing, 2)
            
            TweetActionsView(tweet: tweet)
            
            Divider()
        }
        .padding(.leading, -16)
    }
}
