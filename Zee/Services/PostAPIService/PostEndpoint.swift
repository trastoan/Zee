//
//  PostEndpoint.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import Foundation

enum PostEndpoint: ServiceEndpoint {
    case allPosts

    var path: String {
        switch self {
        case .allPosts:
            return "/posts"
        }
    }

    var baseUrl: String { "https://jsonplaceholder.typicode.com" }

    var queryParameters: [String : String]? { nil }

    var method: HttpMethod {
        switch self {
        case .allPosts:
            return .get
        }
    }
}
