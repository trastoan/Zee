//
//  PostDetailsSpies.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import UIKit
@testable import Zee

struct MockedCommentService: CommentServiceProtocol {
    func commentsForPost(_ id: Int) async throws -> [Zee.Comment] { CommentsFixture.commentsList() }
}

struct MockedUserService: UserServiceProtocol {
    func userDetails(_ id: Int) async throws -> Zee.User { UserFixture.user() }
}

