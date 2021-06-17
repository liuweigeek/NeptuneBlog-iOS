//
//  UserProfileView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/16.
//

import SwiftUI

struct UserProfileView: View {

    @State var selectedFilter: TweetFilterOptions = .tweets
    @ObservedObject var viewModel: ProfileViewModel
    @EnvironmentObject var authViewModel: AuthViewModel

    init(userId: Int) {
        viewModel = ProfileViewModel(forUser: userId) { errorMsg in

        }
    }

    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(viewModel: viewModel)
                        .padding()

                FilterButtonView(selectedOption: $selectedFilter)
                        .padding(.vertical)

                ForEach(viewModel.tweets) { tweet in
                    TweetCell(tweet: tweet)
                }
                        .padding(.horizontal)
            }
        }
                .navigationTitle(viewModel.user?.username ?? "")
                .navigationBarItems(trailing: Button(action: {
                    authViewModel.signOut()
                }, label: {
                    if viewModel.isSelf() {
                        Text("Sign Out")
                    }
                }))
    }
}
