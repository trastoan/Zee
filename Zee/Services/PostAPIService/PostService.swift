//
//  PostService.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import Foundation

protocol PostServiceProtocol {
    func listAllPosts() async throws -> [Post]
}

struct PostService: PostServiceProtocol {
    private let client: HTTPClient

    init(client: HTTPClient = HTTPWorker()) {
        self.client = client
    }

    func listAllPosts() async throws -> [Post] {
        try await client.requestObject(endpoint: PostEndpoint.allPosts)
    }
}
