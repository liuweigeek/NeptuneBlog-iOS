//
//  User.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/15.
//

import Foundation

struct User: Identifiable, Codable {

    let id: Int?
    let email: String?
    let username: String
    let name: String
    let smallAvatar: String?
    let mediumAvatar: String?
    let largeAvatar: String?
    let password: String?
    let birthday: String?
    let gender: String?
    let createAt: String?
    let lang: String?
    let token: String?
    let followingCount: Int?
    let followersCount: Int?
    let collections: [String]?

    init(email: String?, username: String, name: String, password: String) {
        self.email = email
        self.username = username
        self.name = name
        self.password = password
        self.id = nil
        self.smallAvatar = nil
        self.mediumAvatar = nil
        self.largeAvatar = nil
        self.birthday = nil
        self.gender = nil
        self.createAt = nil
        self.lang = nil
        self.token = nil
        self.followingCount = 0
        self.followersCount = 0
        self.collections = [String]()
    }
}
