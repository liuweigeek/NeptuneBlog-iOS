//
//  AuthViewModel.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/24.
//

import SwiftUI
import Alamofire

class FeedViewModel: ObservableObject {

    private let session = SessionManager.shared.session

    @Published var tweets = [Tweet]()
    private var offset = 0
    private var limit = Constant.PAGE_LIMIT
    
    init() {
        fetchFollowingTweets { errMsg in
            
        }
    }

    func fetchFollowingTweets(failureCompletion: @escaping (String) -> Void) {

        let param = ["offset": offset, "limit": limit]

        session.request(Constant.SERVER_HOST + Constant.API.FETCH_FOLLOWING_TWEETS,
                method: .get,
                parameters: param
        )
        .responseJSON { response in
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
                        print("failed to parsing user body: \(error)")
                        failureCompletion("发送失败")
                    }
                } else {
                    print("failed to parsing user body")
                    failureCompletion("发送失败")
                }
            case .failure:
                failureCompletion("发送失败")
            }
        }
    }

}
