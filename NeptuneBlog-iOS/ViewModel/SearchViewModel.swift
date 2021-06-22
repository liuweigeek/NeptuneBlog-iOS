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
        ).responseJSON { response in
            switch response.result {
            case .success:
                guard  let searchRes = response.value as? [String: Any] else {
                    return
                }
                self.users = searchRes["users"] as? [User] ?? [User]()
                self.tweets = searchRes["tweets"] as? [Tweet] ?? [Tweet]()
            case .failure:
                failureCompletion((response.value as? ErrorResponse)?.message ?? "搜索失败")
            }
        }
    }

}
