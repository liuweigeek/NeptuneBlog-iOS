//
//  SessionManager.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/20.
//

import SwiftUI
import Alamofire

class SessionManager {
    
    static let shared = SessionManager()
    var session: Session
    
    init() {
        session = Session(interceptor: JwtTokenAdapter())
    }
}

class JwtTokenAdapter: RequestInterceptor {
    
    let userSessionManager = UserSessionManager.shared
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        if urlRequest.url?.absoluteString.hasSuffix("/auth-server/auth/signIn") == true
            || urlRequest.url?.absoluteString.hasSuffix("/auth-server/auth/signUp") == true {
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest
        
        guard let token = userSessionManager.getToken() else {
            AuthViewModel.shared.signOut()
            return
        }
        urlRequest.setValue(token, forHTTPHeaderField: "authorization")
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("HTTP request failed: \(error.localizedDescription)")
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            AuthViewModel.shared.signOut()
        } else {
            completion(.doNotRetry)
        }
    }
}
