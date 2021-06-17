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
                KFImage(URL(string: tweet.author.mediumAvatar ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(tweet.author.name)
                            .font(.system(size: 14, weight: .semibold))

                    Text("@\(tweet.author.username)")
                            .font(.system(size: 14))
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

                    Text("Retweets")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                }

                HStack(spacing: 4) {
                    Text("0")
                            .font(.system(size: 14, weight: .semibold))

                    Text("Likes")
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