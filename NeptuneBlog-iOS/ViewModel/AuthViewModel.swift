//
//  AuthViewModel.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/24.
//

import SwiftUI
import Alamofire

class AuthViewModel: ObservableObject {

    @ObservedObject var userSessionManager = UserSessionManager.shared

    static let shared = AuthViewModel()

    func signIn(withUsername username: String, password: String, failureCompletion: @escaping (String) -> Void) {

        let loginParam = ["username": username, "password": password]
        AF.request(Constant.SERVER_HOST + Constant.API.SIGN_IN,
                   method: .post,
                   parameters: loginParam
        )
        .responseJSON { response in
            switch response.result {
            case .success(let json):
                if let responseJson = (json as? [String: Any]) {
                    do {
                        if response.response?.statusCode == 200 {
                            let user: User = try JsonUtils.from(data: responseJson)
                            let authUser = AuthUser(id: user.id!, email: user.email, username: user.username,
                                                    name: user.name, smallAvatar: user.smallAvatar, mediumAvatar: user.mediumAvatar,
                                                    largeAvatar: user.largeAvatar, lang: user.lang, token: user.token!)
                            self.userSessionManager.setCurrentUser(authUser)
                        } else {
                            let errorResponse: ErrorResponse = try JsonUtils.from(data: responseJson)
                            print("signIn failed: \(errorResponse.message)")
                            failureCompletion(errorResponse.message)
                        }
                    } catch {
                        print("failed to parsing user body: \(error.localizedDescription)")
                        failureCompletion("登录失败")
                    }
                } else {
                    print("failed to parsing user body")
                    failureCompletion("登录失败")
                }
            case .failure:
                failureCompletion("登录失败")
            }
        }
    }

    func signUp(user: User, profileImage: UIImage?, failureCompletion: @escaping (String) -> Void) {

        AF.request(Constant.SERVER_HOST + Constant.API.SIGN_UP,
                   method: .post,
                   parameters: user,
                   encoder: JSONParameterEncoder.default
        ).responseJSON { response in
            switch response.result {
            case .success:
                guard let user = response.value as? User else {
                    return
                }
                self.userSessionManager.setCurrentUser(AuthUser(id: user.id!, email: user.email, username: user.username,
                                                                name: user.name, smallAvatar: user.smallAvatar, mediumAvatar: user.mediumAvatar,
                                                                largeAvatar: user.largeAvatar, lang: user.lang, token: user.token!))

                guard let profileImage = profileImage else {
                    return
                }
                let imageData = profileImage.pngData()!

                AF.upload(multipartFormData: { multipartFormData in
                    multipartFormData.append(imageData, withName: "file")
                }, to: Constant.SERVER_HOST + Constant.API.UPLOAD_AVATAR)
                .responseDecodable(of: User.self) { response in
                    switch response.result {
                    case .success:
                        guard let user = response.value else { return }
                        self.userSessionManager.setCurrentUser(AuthUser(id: user.id!, email: user.email, username: user.username,
                                                                        name: user.name, smallAvatar: user.smallAvatar, mediumAvatar: user.mediumAvatar,
                                                                        largeAvatar: user.largeAvatar, lang: user.lang, token: user.token!))
                    case .failure:
                        failureCompletion("上传头像失败")
                    }
                }
                .responseDecodable(of: ErrorResponse.self) { response in
                    failureCompletion(response.value?.message ?? "上传头像失败")
                }
            case .failure:
                failureCompletion((response.value as? ErrorResponse)?.message ?? "注册失败")
            }
        }
    }

    func signOut() {
        userSessionManager.removeUser()
    }

}
