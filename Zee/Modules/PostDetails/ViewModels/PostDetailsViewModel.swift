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

    func loadExtraInformation()
    func changeFavoriteStatus()
}

class PostDetailViewModel: PostDetailModel {
    var title: String { "Details" }

    var post: Post
    var user: User?
    var comments: [Comment] = []

    var didFinishLoadingDetails: (() -> Void)?

    private let userService: UserServiceProtocol
    private let commentService: CommentServiceProtocol
    private let favoriteService: FavoriteServiceProtocol

    init(post: Post,
         userService: UserServiceProtocol = UserService(),
         commentService: CommentServiceProtocol = CommentService(),
         favoriteService: FavoriteServiceProtocol = FavoriteServices()) {
        self.userService = userService
        self.commentService = commentService
        self.favoriteService = favoriteService
        self.post = post
    }

    @MainActor
    func loadExtraInformation() {
        Task {
            user = try? await userService.userDetails(post.userId)
            comments = try await commentService.commentsForPost(post.id)
            didFinishLoadingDetails?()
        }
    }

    func changeFavoriteStatus() {
        if post.isFavorite {
            favoriteService.removeFromFavorites(post: post)
        } else {
            favoriteService.addToFavorites(post: post)
        }
        post.isFavorite.toggle()
    }
}
