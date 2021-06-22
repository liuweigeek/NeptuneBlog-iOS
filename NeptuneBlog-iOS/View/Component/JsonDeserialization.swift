//
//  JsonDeserialization.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/22.
//

protocol JsonDeserialization {
    
    static func from<T>(data: [String: Any]) throws -> T
}
