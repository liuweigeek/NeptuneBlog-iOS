//
//  UploadTweetViewModel.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/6/6.
//

import SwiftUI
import Alamofire

class UploadTweetViewModel: ObservableObject {

    func publishTweet(text: String, successfulCompletion: @escaping (Tweet) -> Void, failureCompletion: @escaping (String) -> Void) {

        let param = ["text": text]
        AF.request(Constant.SERVER_HOST + Constant.API.PUBLISH_TWEET,
                method: .post,
                parameters: param,
                encoder: JSONParameterEncoder.default
        ).responseJSON { response in
            switch response.result {
            case .success:
                let tweet = response.value as? Tweet
                successfulCompletion(tweet!)
            case .failure:
                failureCompletion((response.value as? ErrorResponse)?.message ?? "发送失败")
            }
        }
    }

}
