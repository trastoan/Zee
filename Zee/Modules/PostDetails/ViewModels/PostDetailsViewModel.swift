//
//  PostDetailsViewModel.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import Foundation

protocol PostDetailModel {
    var title: String { get }
    var post: Post { get }
    var user: User? { get }
    var comments: [Comment] { get }
    var didFinishLoadingDetails: (() -> Void)? { get set }

    func loadExtraInformation() async throws
}

class PostDetailViewModel: PostDetailModel {
    var title: String { "Details" }

    var post: Post
    var user: User?
    var comments: [Comment] = []

    var didFinishLoadingDetails: (() -> Void)?

    private let userService: UserServiceProtocol
    private let commentService: CommentServiceProtocol

    init(post: Post, userService: UserServiceProtocol = UserService(), commentService: CommentServiceProtocol = CommentService()) {
        self.userService = userService
        self.commentService = commentService
        self.post = post
    }

    @MainActor
    func loadExtraInformation() async throws {
        user = try await userService.userDetails(post.userId)
        comments = try await commentService.commentsForPost(post.id)
        didFinishLoadingDetails?()
    }
}
