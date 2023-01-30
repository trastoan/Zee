//
//  CommentEndpoint.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import Foundation

enum CommentEndpoint: ServiceEndpoint {
    case commentsForPost(_ id: Int)

    var path: String {
        switch self {
        case .commentsForPost:
            return "/comments"
        }
    }

    var baseUrl: String { "https://jsonplaceholder.typicode.com" }

    var queryParameters: [String : String]? {
        switch self {
        case .commentsForPost(let id):
            return ["postId" : "\(id)"]
        }
    }

    var method: HttpMethod { .get }
}
