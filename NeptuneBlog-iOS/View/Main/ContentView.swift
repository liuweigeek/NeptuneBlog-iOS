//
//  ContentView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/3.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var userSessionManager = UserSessionManager.shared
    @State private var selectedIndex = 0

    var body: some View {
        Group {
            if userSessionManager.user != nil {
                NavigationView {
                    MainTabView(selectedIndex: $selectedIndex)
                            .navigationBarTitle(tabTitle(forIndex: selectedIndex))
                            .navigationBarTitleDisplayMode(.inline)
                }
            } else {
                LoginView()
            }
        }
    }

    private func tabTitle(forIndex index: Int) -> String {
        switch index {
        case 0:
            return "Home"
        case 1:
            return "Search"
        case 2:
            return "Messages"
        default:
            return ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
