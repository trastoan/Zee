//
//  PostListViewModel.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import Foundation

protocol PostListModel {
    var router: PostListRouterProtocol { get }
    var title: String { get }
    var numberOfPosts: Int { get}

    var hasFinishedFetch: (() -> Void)? { get set }
    func fetch() async throws
    func post(for index: Int) -> Post
    func didSelectPost(at index: Int)
    func viewDidAppear()
}

final class PostListViewModel: PostListModel {

    var router: PostListRouterProtocol
    var service: PostServiceProtocol
    var favoriteService: FavoriteServiceProtocol
    private var posts: [Post] = []

    var title: String { "Posts List" }
    var numberOfPosts: Int { return posts.count }

    //Bindings
    var hasFinishedFetch: (() -> Void)?

    init(router: PostListRouterProtocol,
        service: PostServiceProtocol = PostService(),
        favoriteService: FavoriteServiceProtocol = FavoriteServices()) {
        self.router = router
        self.service = service
        self.favoriteService = favoriteService
    }

    @MainActor
    func fetch() async throws {
        posts = try await service.listAllPosts()
        parsePosts()
        hasFinishedFetch?()
    }

    func post(for index: Int) -> Post { posts[index] }

    func didSelectPost(at index: Int) {
        router.presentDetailsForPost(posts[index])
    }

    func viewDidAppear() {
        parsePosts()
        hasFinishedFetch?()
    }

    private func parsePosts() {
        posts = favoriteService.parseFavorites(posts: posts)
        posts.sort(by: { $0.isFavorite && !$1.isFavorite })
    }
}
