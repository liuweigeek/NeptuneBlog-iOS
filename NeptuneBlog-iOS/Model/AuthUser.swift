//
//  User.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/15.
//

import Foundation

class AuthUser: Codable {

    var id: Int
    var email: String?
    var username: String
    var name: String
    var smallAvatar: String?
    var mediumAvatar: String?
    var largeAvatar: String?
    var lang: String?
    var token: String

    init(id: Int, email: String?, username: String, name: String,
         smallAvatar: String?, mediumAvatar: String?, largeAvatar: String?,
         lang: String?, token: String) {
        self.id = id
        self.email = email
        self.username = username
        self.name = name
        self.smallAvatar = smallAvatar
        self.mediumAvatar = mediumAvatar
        self.largeAvatar = largeAvatar
        self.lang = lang
        self.token = token
    }
}
