//
//  UserSessionManager.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/21.
//

import Foundation

class UserSessionManager: ObservableObject {
    
    static let shared = UserSessionManager()
    private let userDefaults = UserDefaults.standard
    private var token: String?
    
    @Published var user: AuthUser?
    
    init() {
        user = getCurrentUser()
        token = getToken()
    }
    
    private func getCurrentUser() -> AuthUser? {
        if user == nil {
            if let data = userDefaults.data(forKey: Constant.AUTH_USER_KEY) {
                do {
                    let decoder = JSONDecoder()
                    user = try decoder.decode(AuthUser.self, from: data)
                } catch {
                    print("Unable to decode AuthUser: \(error)")
                }
            }
        }
        return user
    }
    
    func getToken() -> String? {
        return getCurrentUser()?.token
    }
    
    func setCurrentUser(_ user: AuthUser) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            self.userDefaults.set(data, forKey: Constant.AUTH_USER_KEY)
        } catch {
            print("Unable to Decode Note (\(error.localizedDescription))")
            return
        }
        self.user = user
        self.token = user.token
    }
    
    func removeUser() {
        DispatchQueue.main.async {
            self.user = nil
        }
        self.token = nil
        self.userDefaults.removeObject(forKey: Constant.AUTH_USER_KEY)
    }
}
