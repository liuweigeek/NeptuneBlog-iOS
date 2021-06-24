//
//  ProfileViewModel.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/6/2.
//

import SwiftUI
import Alamofire

class ProfileViewModel: ObservableObject {

    private let session = SessionManager.shared.session

    @ObservedObject var userSessionManager = UserSessionManager.shared

    @Published var user: User?
    @Published var tweets = [Tweet]()
    
    @Published var isFollowing = false

    private let userId: Int

    private var offset = 0
    private var limit = Constant.PAGE_LIMIT

    init(forUser userId: Int, failureCompletion: @escaping (String) -> Void) {
        self.userId = userId
        getUserById(failureCompletion: failureCompletion)
        findTweetsByUserId(failureCompletion: failureCompletion)
    }

    func follow(successfulCompletion: @escaping (User) -> Void, failureCompletion: @escaping (String) -> Void) {
        let param = ["userId": userId]
        session.request(Constant.SERVER_HOST + Constant.API.FOLLOW_USER,
                method: .post,
                parameters: param,
                encoder: JSONParameterEncoder.default
        ).responseJSON { response in
            switch response.result {
            case .success(let json):
                if let responseJson = (json as? [String: Any]) {
                    do {
                        if response.response?.statusCode == 200 {
                            let user: User = try JsonUtils.from(data: responseJson)
                            successfulCompletion(user)
                        } else {
                            let errorResponse: ErrorResponse = try JsonUtils.from(data: responseJson)
                            print("follow user failed: \(errorResponse.message)")
                            failureCompletion(errorResponse.message)
                        }
                    } catch {
                        print("failed to parsing user body: \(error)")
                        failureCompletion("关注失败")
                    }
                } else {
                    print("failed to parsing user body")
                    failureCompletion("关注失败")
                }
            case .failure:
                failureCompletion("关注失败")
            }
        }
    }

    func unfollow(successfulCompletion: @escaping (User) -> Void, failureCompletion: @escaping (String) -> Void) {
        session.request(Constant.SERVER_HOST + String(format: Constant.API.UNFOLLOW_USER, userId),
                method: .delete
        ).responseJSON { response in
            switch response.result {
            case .success(let json):
                if let responseJson = (json as? [String: Any]) {
                    do {
                        if response.response?.statusCode == 200 {
                            let user: User = try JsonUtils.from(data: responseJson)
                            successfulCompletion(user)
                        } else {
                            let errorResponse: ErrorResponse = try JsonUtils.from(data: responseJson)
                            print("unfollow user failed: \(errorResponse.message)")
                            failureCompletion(errorResponse.message)
                        }
                    } catch {
                        print("failed to parsing user body: \(error)")
                        failureCompletion("取消关注失败")
                    }
                } else {
                    print("failed to parsing user body")
                    failureCompletion("取消关注失败")
                }
            case .failure:
                failureCompletion("取消关注失败")
            }
        }
    }

    func findTweetsByUserId(failureCompletion: @escaping (String) -> Void) {

        let param = ["offset": offset, "limit": limit]
        session.request(Constant.SERVER_HOST + String(format: Constant.API.FETCH_TWEETS_BY_USER, userId),
                method: .get,
                parameters: param
        ).responseJSON { response in
            switch response.result {
            case .success(let json):
                if let responseJson = (json as? [String: Any]) {
                    do {
                        if response.response?.statusCode == 200 {
                            let tweetsRes: Pageable<Tweet> = try JsonUtils.from(data: responseJson)
                            for tweet in tweetsRes.content ?? [Tweet]() {
                                self.tweets.append(tweet)
                            }
                            self.offset += tweetsRes.numberOfElements
                        } else {
                            let errorResponse: ErrorResponse = try JsonUtils.from(data: responseJson)
                            print("fetch tweets failed: \(errorResponse.message)")
                            failureCompletion(errorResponse.message)
                        }
                    } catch {
                        print("failed to parsing tweets body: \(error)")
                        failureCompletion("获取用户推文失败")
                    }
                } else {
                    print("failed to parsing tweets body")
                    failureCompletion("获取用户推文失败")
                }
            case .failure:
                failureCompletion("获取用户推文失败")
            }
        }
    }

    func getUserById(failureCompletion: @escaping (String) -> Void) {
        session.request(Constant.SERVER_HOST + String(format: Constant.API.GET_USER_BY_ID, userId),
                method: .get
        ).responseJSON { response in
            switch response.result {
            case .success(let json):
                if let responseJson = (json as? [String: Any]) {
                    do {
                        if response.response?.statusCode == 200 {
                            let user: User = try JsonUtils.from(data: responseJson)
                            self.user = user
                            print(user.connections)
                            self.isFollowing = user.connections?.contains(UserConnection.FOLLOWING.rawValue) ?? false
                        } else {
                            let errorResponse: ErrorResponse = try JsonUtils.from(data: responseJson)
                            print("fetch user failed: \(errorResponse.message)")
                            failureCompletion(errorResponse.message)
                        }
                    } catch {
                        print("failed to parsing user body: \(error)")
                        failureCompletion("查询用户信息失败")
                    }
                } else {
                    print("failed to parsing user body")
                    failureCompletion("查询用户信息失败")
                }
            case .failure:
                failureCompletion("查询用户信息失败")
            }
        }
    }

}

extension ProfileViewModel {

    func isSelf() -> Bool {
        guard let authUser = userSessionManager.user else {
            return false
        }
        return authUser.id == userId
    }

}
