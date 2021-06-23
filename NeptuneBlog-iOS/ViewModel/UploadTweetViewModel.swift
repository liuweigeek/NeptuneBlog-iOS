//
//  UploadTweetViewModel.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/6/6.
//

import SwiftUI
import Alamofire

class UploadTweetViewModel: ObservableObject {
    
    private let session = SessionManager.shared.session

    func publishTweet(text: String, successfulCompletion: @escaping (Tweet) -> Void, failureCompletion: @escaping (String) -> Void) {

        let param = ["text": text]
        session.request(Constant.SERVER_HOST + Constant.API.PUBLISH_TWEET,
                method: .post,
                parameters: param,
                encoder: JSONParameterEncoder.default
        )
        .responseJSON { response in
            switch response.result {
            case .success(let json):
                if let responseJson = (json as? [String: Any]) {
                    do {
                        if response.response?.statusCode == 200 {
                            let tweet: Tweet = try JsonUtils.from(data: responseJson)
                            successfulCompletion(tweet)
                        } else {
                            let errorResponse: ErrorResponse = try JsonUtils.from(data: responseJson)
                            print("post tweet failed: \(errorResponse.message)")
                            failureCompletion(errorResponse.message)
                        }
                    } catch {
                        print("failed to parsing tweet body: \(error)")
                        failureCompletion("发送失败")
                    }
                } else {
                    print("failed to parsing tweet body")
                    failureCompletion("发送失败")
                }
            case .failure:
                failureCompletion("发送失败")
            }
        }
    }
}
