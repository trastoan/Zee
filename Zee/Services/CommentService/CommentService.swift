//
//  CommentService.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import Foundation

protocol CommentServiceProtocol {
    func commentsForPost(_ id: Int) async throws -> [Comment]
}

struct CommentService: CommentServiceProtocol {
    private let client: HTTPClient

    init(client: HTTPClient = HTTPWorker()) {
        self.client = client
    }

    func commentsForPost(_ id: Int) async throws -> [Comment] {
        try await client.requestObject(endpoint: CommentEndpoint.commentsForPost(id))
    }
}
