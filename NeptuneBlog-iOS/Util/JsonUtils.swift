//
// Created by Scott Lau on 2021/6/22.
//

import Foundation

struct JsonUtils {
    
    static func from<T: Decodable>(data: [String: Any]) throws -> T {
        let json = try JSONSerialization.data(withJSONObject: data)
        return try JSONDecoder().decode(T.self, from: json)
    }
}
