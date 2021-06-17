//
//  Pageable.swift
//  NeptuneBlog-iOS
//
//  Created by Scott Lau on 2021/6/15.
//

import Foundation

struct Pageable<T> {

    let number: Int
    let size: Int
    let content: [T]?
    let empty: Bool
    let first: Bool
    let last: Bool
    let numberOfElements: Int
    let totalPages: Int
    let totalElements: Int
}
