//
//  NeptuneBlog_iOSApp.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/14.
//

import SwiftUI

@main
struct NeptuneBlog_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel())
        }
    }
}
