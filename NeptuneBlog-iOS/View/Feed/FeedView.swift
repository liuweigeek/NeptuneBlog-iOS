//
//  FeedView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/5.
//

import SwiftUI

struct FeedView: View {
    
    @State var isShowingNewTweetView = false
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.tweets) { tweet in
                        NavigationLink(
                            destination: LazyView(TweetDetailView(tweet: tweet)),
                            label: {
                                TweetCell(tweet: tweet)
                            }
                        ).onAppear {
                            let last = viewModel.tweets.last
                            if last?.id == tweet.id {
                                viewModel.fetchFollowingTweets { errorMsg in
                                    
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            
            Button(action: {
                isShowingNewTweetView = true
            }, label: {
                Image("tweet")
                    .resizable()
                    .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                    .frame(width: 32, height: 32)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $isShowingNewTweetView) {
                NewTweetView(isPresented: $isShowingNewTweetView)
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
