//
//  SearchResult.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/15.
//

import Foundation

struct SearchResult: Codable {

    let users: [User]
    let tweets: [Tweet]
}
