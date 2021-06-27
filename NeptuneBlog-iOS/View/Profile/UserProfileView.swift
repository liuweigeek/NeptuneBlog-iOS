//
//  UserProfileView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/16.
//

import SwiftUI

struct UserProfileView: View {
    
    @State private var selectedFilter: TweetFilterOptions = .tweets
    @State private var errorMessage = ""
    @State private var showingAlert = false
    @ObservedObject var viewModel: ProfileViewModel
    let authViewModel = AuthViewModel.shared
    
    init(userId: Int) {
        viewModel = ProfileViewModel(forUser: userId)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(viewModel: viewModel)
                    .padding()
                
                FilterButtonView(selectedOption: $selectedFilter)
                    .padding(.vertical)
                
                ForEach(viewModel.tweets) { tweet in
                    NavigationLink(
                        destination: LazyView(TweetDetailView(tweet: tweet)),
                        label: {
                            TweetCell(tweet: tweet)
                        }
                    )
                    .onAppear {
                        let last = viewModel.tweets.last
                        if last?.id == tweet.id {
                            viewModel.findTweetsByUserId { errorMessage in
                                self.errorMessage = errorMessage
                                self.showingAlert = true
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear(perform: {
            viewModel.getUserById { errorMessage in
                self.errorMessage = errorMessage
                self.showingAlert = true
            }
            viewModel.findTweetsByUserId { errorMessage in
                self.errorMessage = errorMessage
                self.showingAlert = true
            }
        })
        .navigationTitle(viewModel.user?.username ?? "")
        .navigationBarItems(trailing: Button(action: {
            authViewModel.signOut()
        }, label: {
            if viewModel.isSelf() {
                Text("退出登录")
            }
        }))
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("\(errorMessage)"), dismissButton: .default(Text("好的")))
        }
    }
}
