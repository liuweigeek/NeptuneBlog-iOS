//
//  User.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/15.
//

import Foundation

struct User: Identifiable {
    
    let id: Int?
    let email: String
    let username: String
    let name: String
    let smallAvatar: String?
    let mediumAvatar: String?
    let largeAvatar: String?
    let password: String?
    let birthday: Date?
    let gender: String?
    let createAt: Date?
    let lang: String?
    let token: String?
    let followingCount: Int?
    let followersCount: Int?
    let collections: [String]?
}
