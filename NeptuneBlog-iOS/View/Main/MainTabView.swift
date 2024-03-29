//
//  MainTabView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/6/14.
//

import SwiftUI
import Kingfisher

struct MainTabView: View {
    
    let authViewModel = AuthViewModel.shared
    @Binding var selectedIndex: Int
    @ObservedObject var userSessionManager = UserSessionManager.shared
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            LazyView(FeedView())
                .onTapGesture {
                    selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("主页")
                }
                .tag(0)
            LazyView(SearchView())
                .onTapGesture {
                    selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("搜索")
                }
                .tag(1)
        }
        .navigationBarItems(leading: Button(action: {}, label: {
            if let user = userSessionManager.user {
                NavigationLink(
                    destination: LazyView(UserProfileView(userId: user.id)),
                    label: {
                        if let smallAvatar = user.smallAvatar {
                            KFImage(URL(string: smallAvatar))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 32, height: 32)
                                .clipShape(Circle())
                        }
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
