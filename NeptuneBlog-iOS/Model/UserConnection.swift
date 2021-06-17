//
//  UserConnection.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/15.
//

enum UserConnection: String {

    case FOLLOWING = "following"
    case FOLLOWING_REQUESTED = "followingRequested"
    case FOLLOWED_BY = "followedBy"
    case NONE = "none"
    case BLOCKING = "blocking"
    case MUTING = "muting"
}
