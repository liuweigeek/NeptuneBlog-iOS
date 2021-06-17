//
//  ProfileViewModel.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/6/2.
//

import SwiftUI
import Alamofire

class ProfileViewModel: ObservableObject {

    @Published var user: User?
    @Published var tweets = [Tweet]()
    @EnvironmentObject var authViewModel: AuthViewModel

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
        AF.request(Constant.SERVER_HOST + Constant.API.FOLLOW_USER,
                method: .post,
                parameters: param,
                encoder: JSONParameterEncoder.default
        ).responseJSON { response in
            switch response.result {
            case .success:
                guard let user = response.value as? User else {
                    return
                }
                successfulCompletion(user)
            case .failure:
                failureCompletion((response.value as? ErrorResponse)?.message ?? "关注失败")
            }
        }
    }

    func unfollow(successfulCompletion: @escaping (User) -> Void, failureCompletion: @escaping (String) -> Void) {
        AF.request(Constant.SERVER_HOST + String(format: Constant.API.UNFOLLOW_USER, userId),
                method: .delete
        ).responseJSON { response in
            switch response.result {
            case .success:
                guard let user = response.value as? User else {
                    return
                }
                successfulCompletion(user)
            case .failure:
                failureCompletion((response.value as? ErrorResponse)?.message ?? "取消关注失败")
            }
        }
    }

    func findTweetsByUserId(failureCompletion: @escaping (String) -> Void) {

        let param = ["offset": offset, "limit": limit]
        AF.request(Constant.SERVER_HOST + String(format: Constant.API.FETCH_TWEETS_BY_USER, userId),
                method: .get,
                parameters: param
        ).responseJSON { response in
            switch response.result {
            case .success:
                guard let tweetsRes = response.value as? Pageable<Tweet> else {
                    return
                }
                for tweet in tweetsRes.content ?? [Tweet]() {
                    self.tweets.append(tweet)
                }
                self.offset += tweetsRes.numberOfElements
            case .failure:
                failureCompletion((response.value as? ErrorResponse)?.message ?? "获取用户推文失败")
            }
        }
    }

    func getUserById(failureCompletion: @escaping (String) -> Void) {
        AF.request(Constant.SERVER_HOST + String(format: Constant.API.GET_USER_BY_ID, userId),
                method: .get
        ).responseJSON { response in
            switch response.result {
            case .success:
                guard let user = response.value as? User else {
                    return
                }
                self.user = user
            case .failure:
                failureCompletion((response.value as? ErrorResponse)?.message ?? "查询用户信息失败")
            }
        }
    }
}

extension ProfileViewModel {

    func isSelf() -> Bool {
        guard let authUser = authViewModel.authUser else {
            return false
        }
        return authUser.id == userId
    }

    func isFollowing() -> Bool {
        ((user?.collections?.contains(UserConnection.FOLLOWING.rawValue)) != nil);
    }
}
