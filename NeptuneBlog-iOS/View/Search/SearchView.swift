//
//  SearchView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/5.
//

import SwiftUI

struct SearchView: View {

    @State var searchText = ""
    @ObservedObject var viewModel = SearchViewModel()

    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                    .padding()

            VStack(alignment: .leading) {
                ForEach(viewModel.tweets) { tweet in
                    NavigationLink(
                            destination: LazyView(TweetDetailView(tweet: tweet)),
                            label: {
                                TweetCell(tweet: tweet)
                            }
                    )
                }
            }
                    .padding(.leading)
        }
                .navigationBarTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
