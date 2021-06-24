//
//  Constant.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/15.
//

import Foundation

struct Constant {

    static let SERVER_HOST = "http://192.168.8.195:8080"

    struct API {
        static let SIGN_IN = "/auth-server/auth/signIn"
        static let SIGN_UP = "/auth-server/auth/signUp"
        static let UPLOAD_AVATAR = "/user-server/avatars"

        static let PUBLISH_TWEET = "/tweet-server/tweets"
        static let FETCH_TWEETS_BY_USER = "/tweet-server/tweets/user/%d"
        static let FETCH_FOLLOWING_TWEETS = "/tweet-server/tweets/following"

        static let GET_USER_BY_ID = "/user-server/users/%d"
        static let GET_USER_BY_USERNAME = "/user-server/users/username/%@"

        static let FOLLOW_USER = "/user-server/friendships"
        static let UNFOLLOW_USER = "/user-server/friendships/%d"

        static let SEARCH = "/search-server/search"
    }

    static let AUTH_USER_KEY = "user"

    static let PAGE_LIMIT = 20
}
