//
//  MainTabView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/6/14.
//

import SwiftUI
import Kingfisher

struct MainTabView: View {

    @Binding var selectedIndex: Int
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        TabView(selection: $selectedIndex) {
            FeedView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
            SearchView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .tag(1)
        }
                .navigationBarTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    viewModel.signOut()
                }, label: {
                    if let user = viewModel.authUser {
                        NavigationLink(
                                destination: LazyView(UserProfileView(userId: user.id)),
                                label: {
                                    KFImage(URL(string: user.smallAvatar ?? ""))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 32, height: 32)
                                            .clipShape(Circle())
                                }
                        )
                    }
                }))
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(selectedIndex: .constant(0))
    }
}