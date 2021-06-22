//
//  Tweet.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/15.
//

import Foundation

struct Tweet: Identifiable, Codable {

    let id: Int
    let author: User
    let text: String
    let source: String?
    let createAt: String

    let publicMetrics: PublicMetrics
    
    var createDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.date(from: createAt) ?? Date()
    }

    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: createDate, to: Date()) ?? ""
    }

    var detailedTimestampString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a · MM/dd/yyyy"
        return formatter.string(from: createDate)
    }
}

struct PublicMetrics: Codable {
    let retweetCount: Int
    let quoteCount: Int
    let replyCount: Int
    let likeCount: Int
}
