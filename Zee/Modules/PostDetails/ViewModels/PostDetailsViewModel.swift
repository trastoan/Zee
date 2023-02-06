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
    
    func loadExtraInformation() async
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
    func loadExtraInformation() async {
        await withTaskGroup(of: Void.self, body: {group in
            group.addTask { await self.loadUser() }
            group.addTask { await self.loadComments() }
        })
        didFinishLoadingDetails?()
    }

    private func loadUser() async {
        user = try? await userService.userDetails(post.userId)
    }

    private func loadComments() async {
        let fetchedComments = try? await commentService.commentsForPost(post.id)
        comments = fetchedComments ?? []
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
