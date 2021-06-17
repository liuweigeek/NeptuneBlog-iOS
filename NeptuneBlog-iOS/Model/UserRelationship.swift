//
//  UserRelationship.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/15.
//

import Foundation

struct UserRelationship: Identifiable, Codable {

    let id: Int?
    let username: String
    let name: String
    let smallAvatar: String?
    let mediumAvatar: String?
    let largerAvatar: String?
    let followDate: Date?
    let followFrom: String?
    let connections: [String]
}
