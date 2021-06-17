//
//  AuthViewModel.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/24.
//

import SwiftUI
import Alamofire

class AuthViewModel: ObservableObject {

    let userDefaults = UserDefaults.standard
    @Published var authUser: AuthUser?
    @Published var token: String?

    init() {
        authUser = getCurrentUser()
        if let authUser = authUser {
            token = authUser.token
        }
    }

    func signIn(withUsername username: String, password: String, failureCompletion: @escaping (String) -> Void) {

        let loginParam = ["username": username, "password": password]
        AF.request(Constant.SERVER_HOST + Constant.API.SIGN_IN,
                method: .post,
                parameters: loginParam
        ).responseJSON { response in
            switch response.result {
            case .success:
                guard let user = response.value as? User else {
                    return
                }
                let authUser = AuthUser(id: user.id!, email: user.email, username: user.username, name: user.name,
                        smallAvatar: user.smallAvatar, mediumAvatar: user.mediumAvatar, largeAvatar: user.largeAvatar,
                        lang: user.lang, token: user.token!)
                self.userDefaults.set(authUser, forKey: Constant.AUTH_USER_KEY)
            case .failure:
                failureCompletion((response.value as? ErrorResponse)?.message ?? "登录失败")
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
                let authUser = AuthUser(id: user.id!, email: user.email, username: user.username, name: user.name,
                        smallAvatar: user.smallAvatar, mediumAvatar: user.mediumAvatar, largeAvatar: user.largeAvatar,
                        lang: user.lang, token: user.token!)
                self.userDefaults.set(authUser, forKey: Constant.AUTH_USER_KEY)

                guard let profileImage = profileImage else {
                    return
                }
                let imageData = profileImage.pngData()!

                AF.upload(multipartFormData: { multipartFormData in
                            multipartFormData.append(imageData, withName: "file")
                        }, to: Constant.SERVER_HOST + Constant.API.UPLOAD_AVATAR)
                        .responseJSON { response in
                            switch response.result {
                            case .success:
                                guard let user = response.value as? User else {
                                    return
                                }
                                let authUser = AuthUser(id: user.id!, email: user.email, username: user.username, name: user.name,
                                        smallAvatar: user.smallAvatar, mediumAvatar: user.mediumAvatar, largeAvatar: user.largeAvatar,
                                        lang: user.lang, token: user.token!)
                                self.userDefaults.set(authUser, forKey: Constant.AUTH_USER_KEY)
                            case .failure:
                                failureCompletion((response.value as? ErrorResponse)?.message ?? "上传头像失败")
                            }
                        }
            case .failure:
                failureCompletion((response.value as? ErrorResponse)?.message ?? "注册失败")
            }
        }
    }

    func signOut() {
        userDefaults.removeObject(forKey: Constant.AUTH_USER_KEY)
    }

    private func getCurrentUser() -> AuthUser? {
        userDefaults.object(forKey: Constant.AUTH_USER_KEY) as? AuthUser
    }
}
