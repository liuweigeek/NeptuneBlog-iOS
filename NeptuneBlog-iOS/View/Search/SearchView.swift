//
//  SearchView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/5.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView {
            SearchBar(onCommit: { searchText in
                viewModel.users.removeAll()
                viewModel.tweets.removeAll()
                viewModel.searchByKeyword(keyword: searchText) { errorMsg in
                    
                }
            })
            .padding()
            
            if (viewModel.users.count > 0) {
                VStack(alignment: .leading) {
                    Section(header: Text("用户")) {
                        ForEach(viewModel.users) { user in
                            NavigationLink(
                                destination: LazyView(UserProfileView(userId: user.id!)),
                                label: {
                                    UserCell(user: user)
                                }
                            )
                        }
                    }
                }
                .padding(.leading)
                .padding(.bottom)
            }

            if (viewModel.tweets.count > 0) {
                VStack(alignment: .leading) {
                    Section(header: Text("推文")) {
                        ForEach(viewModel.tweets) { tweet in
                            NavigationLink(
                                destination: LazyView(TweetDetailView(tweet: tweet)),
                                label: {
                                    TweetCell(tweet: tweet)
                                }
                            )
                        }
                    }
                }
                .padding(.leading)
                .padding(.bottom)
            }
        }
        .navigationBarTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
