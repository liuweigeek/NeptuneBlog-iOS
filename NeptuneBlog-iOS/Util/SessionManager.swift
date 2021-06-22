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
        session = Session(interceptor: JwtTokenAdapter(userSessionManager: UserSessionManager.shared))
    }
}

class JwtTokenAdapter: RequestInterceptor {
    
    let authViewModel = AuthViewModel.shared
    let userSessionManager: UserSessionManager
    
    init(userSessionManager: UserSessionManager) {
        self.userSessionManager = userSessionManager
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        guard urlRequest.url?.absoluteString.hasSuffix("/auth-server/auth/signIn") == true
                || urlRequest.url?.absoluteString.hasSuffix("/auth-server/auth/signIn") == true else {
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest
        
        guard let token = userSessionManager.getToken() else { return }
        urlRequest.setValue(token, forHTTPHeaderField: "authorization")
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            authViewModel.signOut()
        }
    }
}
