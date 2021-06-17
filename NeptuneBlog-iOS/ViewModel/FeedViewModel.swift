//
//  AuthViewModel.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/24.
//

import SwiftUI
import Alamofire

class FeedViewModel: ObservableObject {

    @Published var tweets = [Tweet]()
    private var offset = 0
    private var limit = Constant.PAGE_LIMIT

    func fetchFollowingTweets(failureCompletion: @escaping (String) -> Void) {

        let param = ["offset": offset, "limit": limit]

        AF.request(Constant.SERVER_HOST + Constant.API.FETCH_FOLLOWING_TWEETS,
                method: .get,
                parameters: param
        ).responseJSON { response in
            switch response.result {
            case .success:
                let tweetsRes = response.value as? Pageable<Tweet>
                for tweet in tweetsRes?.content ?? [Tweet]() {
                    self.tweets.append(tweet)
                }
                self.offset += tweetsRes?.numberOfElements ?? 0
            case .failure:
                failureCompletion((response.value as? ErrorResponse)?.message ?? "发送失败")
            }
        }
    }

}
