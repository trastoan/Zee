//
//  UserService.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import Foundation

protocol UserServiceProtocol {
    func userDetails(_ id: Int) async throws -> User
}

struct UserService: UserServiceProtocol {
    private let client: HTTPClient

    init(client: HTTPClient = HTTPWorker()) {
        self.client = client
    }
    
    func userDetails(_ id: Int) async throws -> User {
        try await client.requestObject(endpoint: UserEndpoint.userDetails(id))
    }
}
