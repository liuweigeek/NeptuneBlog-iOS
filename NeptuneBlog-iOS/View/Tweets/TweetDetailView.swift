//
//  TweetDetailView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/6/8.
//

import SwiftUI
import Kingfisher

struct TweetDetailView: View {
    
    let tweet: Tweet
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                NavigationLink(
                    destination: LazyView(UserProfileView(userId: tweet.author.id!)),
                    label: {
                        if let smallAvatar = tweet.author.smallAvatar {
                            KFImage(URL(string: smallAvatar))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 56, height: 56)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 56, height: 56)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                        }
                    }
                )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(tweet.author.name)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("@\(tweet.author.username)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            
            Text(tweet.text)
                .font(.system(size: 22))
            
            Text(tweet.detailedTimestampString)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Divider()
            
            HStack(spacing: 12) {
                HStack(spacing: 4) {
                    Text("0")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("转推")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                HStack(spacing: 4) {
                    Text("0")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("喜欢")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
            }
            
            Divider()
            
            TweetActionsView(tweet: tweet)
            
            Spacer()
        }
        .padding()
    }
}
