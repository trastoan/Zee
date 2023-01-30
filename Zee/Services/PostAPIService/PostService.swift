//
//  PostService.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import Foundation

protocol PostServiceProtocol {
    func listAllPosts() async throws -> [Post]
    func deletePost(_ id: Int) async throws -> Bool
}

struct PostService: PostServiceProtocol {
    private let client: HTTPClient

    init(client: HTTPClient = HTTPWorker()) {
        self.client = client
    }

    func listAllPosts() async throws -> [Post] {
        try await client.requestObject(endpoint: PostEndpoint.allPosts)
    }

    func deletePost(_ id: Int) async throws -> Bool {
        //MARK: TODO
        return true
    }
}
