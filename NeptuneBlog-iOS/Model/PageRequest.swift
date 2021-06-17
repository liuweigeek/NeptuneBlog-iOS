//
//  PageRequest.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/15.
//

import Foundation

struct PageRequest: Codable {

    let offset: Int
    let limit: Int
}
