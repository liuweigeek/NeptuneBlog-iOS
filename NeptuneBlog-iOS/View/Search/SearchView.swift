//
//  SearchView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/5.
//

import SwiftUI

struct SearchView: View {
    
    @State private var errorMessage = ""
    @State private var showingAlert = false
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView {
            SearchBar(onCommit: { searchText in
                viewModel.users.removeAll()
                viewModel.tweets.removeAll()
                viewModel.searchByKeyword(keyword: searchText) { errorMessage in
                    self.errorMessage = errorMessage
                    self.showingAlert = true
                }
            })
            .padding()
            
            if viewModel.users.count > 0 {
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
            
            if viewModel.tweets.count > 0 {
                VStack(alignment: .leading) {
                    Section(header: Text("推文")) {
                        ForEach(viewModel.tweets) { tweet in
                            NavigationLink(
                                destination: LazyView(TweetDetailView(tweet: tweet)),
                                label: {
                                    TweetCellView(tweet: tweet)
                                }
                            )
                        }
                    }
                }
                .padding(.leading)
                .padding(.bottom)
            }
        }
        .navigationBarTitle("搜索")
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("\(errorMessage)"), dismissButton: .default(Text("好的")))
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
