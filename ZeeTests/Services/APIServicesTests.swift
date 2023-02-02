//
//  APIServicesTests.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import XCTest
@testable import Zee

struct MockedHHTPWorker: HTTPClient {
    func requestObject<Model>(endpoint: Zee.ServiceEndpoint) async throws -> Model where Model : Decodable {
        switch endpoint {
        case PostEndpoint.allPosts:
            return PostFixtures.postsArray() as! Model
        case CommentEndpoint.commentsForPost(0):
            return CommentsFixture.commentsList() as! Model
        case UserEndpoint.userDetails(0):
            return UserFixture.user() as! Model
        default:
            throw HTTPClientError.invalidObject
        }
    }
}

final class APIServicesTests: XCTestCase {
    private var commentService: CommentService!
    private var postService: PostService!
    private var userService: UserService!
    private var mockedWorker: MockedHHTPWorker!

    override func setUp() {
        mockedWorker = MockedHHTPWorker()
        commentService = CommentService(client: mockedWorker)
        postService = PostService(client: mockedWorker)
        userService = UserService(client: mockedWorker)
    }

    func test_allPost_returnThreePosts() async throws {
        let posts = try await postService.listAllPosts()
        XCTAssertEqual(posts.count, 3)
    }

    func test_fetchComments_returnTwoComments() async throws {
        let comments = try await commentService.commentsForPost(0)

        XCTAssertEqual(comments.count, 2)
    }

    func test_fetchUser_returnsValidUser() async throws {
        let user = try await userService.userDetails(0)

        XCTAssertEqual(user.name, "Leanne Graham")
    }
}
