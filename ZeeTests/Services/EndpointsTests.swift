//
//  EndpointsTests.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import XCTest
@testable import Zee

final class EndpointTests: XCTestCase {
    func test_commentEndpoint() {
        let endpoint = CommentEndpoint.commentsForPost(0)
        XCTAssertEqual(endpoint.baseUrl, "https://jsonplaceholder.typicode.com")
        XCTAssertEqual(endpoint.path, "/comments")
        XCTAssertEqual(endpoint.queryParameters, ["postId" : "0"])
        XCTAssertEqual(endpoint.method, .get)
    }

    func test_postEndpoint() {
        let endpoint = PostEndpoint.allPosts
        XCTAssertEqual(endpoint.baseUrl, "https://jsonplaceholder.typicode.com")
        XCTAssertEqual(endpoint.path, "/posts")
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertEqual(endpoint.method, .get)
    }

    func test_userEndpoint() {
        let endpoint = UserEndpoint.userDetails(0)
        XCTAssertEqual(endpoint.baseUrl, "https://jsonplaceholder.typicode.com")
        XCTAssertEqual(endpoint.path, "/users/0")
        XCTAssertNil(endpoint.queryParameters)
        XCTAssertEqual(endpoint.method, .get)
    }
}
