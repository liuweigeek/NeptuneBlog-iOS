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
    
    private let session = SessionManager.shared.session
    static let shared = AuthViewModel()
    
    func signIn(withUsername username: String, password: String, failureCompletion: @escaping (String) -> Void) {
        
        let loginParam = ["username": username, "password": password]
        session.request(Constant.SERVER_HOST + Constant.API.SIGN_IN,
                        method: .post,
                        parameters: loginParam
        )
        .responseJSON { response in
            print(response)
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
                        print("failed to parsing user body: \(error)")
                        failureCompletion("登录失败")
                    }
                } else {
                    print("failed to parsing user body")
                    failureCompletion("登录失败")
                }
            case .failure(let error):
                print("signIn failed: \(error.localizedDescription)")
                failureCompletion("登录失败")
            }
        }
    }
    
    func signUp(user: User, profileImage: UIImage?, failureCompletion: @escaping (String) -> Void) {
        
        session.request(Constant.SERVER_HOST + Constant.API.SIGN_UP,
                        method: .post,
                        parameters: user,
                        encoder: JSONParameterEncoder.default
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
                            
                            guard let imageData = profileImage?.jpegData(compressionQuality: 0.3) else {
                                return
                            }
                            
                            self.session.upload(multipartFormData: { multipartFormData in
                                multipartFormData.append(imageData, withName: "file", fileName: "avatar-\(authUser.id).jpg", mimeType: "image/jpg")
                            }, to: Constant.SERVER_HOST + Constant.API.UPLOAD_AVATAR)
                            .responseJSON{ response in
                                switch response.result {
                                case .success(let json):
                                    if let responseJson = (json as? [String: Any]) {
                                        do {
                                            if response.response?.statusCode == 200 {
                                                let user: User = try JsonUtils.from(data: responseJson)
                                                let authUser = AuthUser(id: user.id!, email: user.email, username: user.username,
                                                                        name: user.name, smallAvatar: user.smallAvatar, mediumAvatar: user.mediumAvatar,
                                                                        largeAvatar: user.largeAvatar, lang: user.lang, token: authUser.token)
                                                self.userSessionManager.setCurrentUser(authUser)
                                            } else {
                                                let errorResponse: ErrorResponse = try JsonUtils.from(data: responseJson)
                                                print("upload avatar failed: \(errorResponse.message)")
                                                failureCompletion(errorResponse.message)
                                            }
                                        } catch {
                                            print("failed to parsing user body: \(error)")
                                            failureCompletion("上传头像失败")
                                        }
                                    } else {
                                        print("failed to parsing user body")
                                        failureCompletion("上传头像失败")
                                    }
                                case .failure(let error):
                                    print("upload avatar failed: \(error.localizedDescription)")
                                    failureCompletion("上传头像失败")
                                }
                            }
                            
                        } else {
                            let errorResponse: ErrorResponse = try JsonUtils.from(data: responseJson)
                            print("signUp failed: \(errorResponse.message)")
                            failureCompletion(errorResponse.message)
                        }
                    } catch {
                        print("failed to parsing user body: \(error)")
                        failureCompletion("注册失败")
                    }
                } else {
                    print("failed to parsing user body")
                    failureCompletion("注册失败")
                }
            case .failure(let error):
                print("signUp failed: \(error.localizedDescription)")
                failureCompletion("注册失败")
            }
        }
    }
    
    func signOut() {
        userSessionManager.removeUser()
    }
    
}
