//
//  Tweet.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/15.
//

import Foundation

struct Tweet: Identifiable {

    let id: Int
    let author: User
    let text: String
    let source: String
    let createAt: Date
    
    let publicMetrics: PublicMetrics
}

struct PublicMetrics {
    let retweetCount: Int
    let quoteCount: Int
    let replyCount: Int
    let likeCount: Int
}
