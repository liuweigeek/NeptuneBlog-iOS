//
//  SearchViewModel.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/31.
//

import Foundation
import Alamofire

class SearchViewModel: ObservableObject {

    private let session = SessionManager.shared.session

    @Published var users = [User]()
    @Published var tweets = [Tweet]()

    func searchByKeyword(keyword: String, failureCompletion: @escaping (String) -> Void) {

        let param = ["q": keyword]
        session.request(Constant.SERVER_HOST + Constant.API.SEARCH,
                method: .get,
                parameters: param
        )
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let json):
                if let responseJson = (json as? [String: [[String: Any]]]) {
                    do {
                        if response.response?.statusCode == 200 {
                            if let userList = responseJson["users"] {
                                var users = [User]()
                                for user in userList {
                                    users.append(try JsonUtils.from(data: user))
                                }
                                self.users = users
                            }
                            if let tweetList = responseJson["tweets"] {
                                var tweets = [Tweet]()
                                for tweet in tweetList {
                                    tweets.append(try JsonUtils.from(data: tweet))
                                }
                                self.tweets = tweets
                            }
                        } else {
                            let errorResponse: ErrorResponse = try JsonUtils.from(data: responseJson)
                            print("search failed: \(errorResponse.message)")
                            failureCompletion(errorResponse.message)
                        }
                    } catch {
                        print("failed to parsing search body: \(error)")
                        failureCompletion("搜索失败")
                    }
                } else {
                    print("failed to parsing search body")
                    failureCompletion("搜索失败")
                }
            case .failure:
                failureCompletion("搜索失败")
            }
        }
    }
}
