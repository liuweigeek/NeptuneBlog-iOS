//
//  TweetCell.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/5.
//

import SwiftUI
import Kingfisher

struct TweetCell: View {

    @Environment(\.colorScheme) var colorScheme

    let tweet: Tweet

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 12) {
                KFImage(URL(string: tweet.author.smallAvatar ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                        .padding(.leading)

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(tweet.author.name)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(colorScheme == .dark ? .white : .black)

                        Text("@\(tweet.author.username) •")
                                .foregroundColor(.gray)

                        Text("String(tweet.createAt)")
                                .foregroundColor(.gray)

                        Spacer()

                        Button(action: {}, label: {
                            Text("...")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.gray)
                        })
                                .padding(.trailing)
                    }

                    Text(tweet.text)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
                    .padding(.vertical)
                    .padding(.trailing)

            TweetActionsView(tweet: tweet)

            Divider()
        }
                .padding(.leading, -16)
    }
}
