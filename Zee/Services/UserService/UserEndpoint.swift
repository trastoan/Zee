//
//  UserEndpoint.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import Foundation

enum UserEndpoint: ServiceEndpoint {
    case userDetails(_ id: Int)

    var path: String {
        switch self {
        case .userDetails(let id):
            return "/users/\(id)"
        }
    }

    var baseUrl: String { "https://jsonplaceholder.typicode.com" }

    var queryParameters: [String : String]? { nil }

    var method: HttpMethod { .get }
}
