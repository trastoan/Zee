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
    func deletePost(at index: Int)
    func viewDidAppear()
}

final class PostListViewModel: PostListModel {

    var router: PostListRouterProtocol
    private var service: PostServiceProtocol
    private var favoriteService: FavoriteServiceProtocol
    private var deletedService: DeleteServiceProtocol
    private var posts: [Post] = []

    var title: String { "Posts List" }
    var numberOfPosts: Int { posts.count }

    //Bindings
    var hasFinishedFetch: (() -> Void)?

    init(router: PostListRouterProtocol,
        service: PostServiceProtocol = PostService(),
        favoriteService: FavoriteServiceProtocol = FavoriteServices(),
         deletedService: DeleteServiceProtocol = DeleteService()) {
        self.router = router
        self.service = service
        self.favoriteService = favoriteService
        self.deletedService = deletedService
    }

    @MainActor
    func fetch() async throws {
        posts = try await service.listAllPosts()
        parsePosts()
    }

    func post(for index: Int) -> Post { posts[index] }

    func didSelectPost(at index: Int) {
        router.presentDetailsForPost(posts[index])
    }

    func viewDidAppear() {
        parsePosts()
    }

    func deletePost(at index: Int) {
        posts.remove(at: index)
        deletedService.addToDeleted(post: posts[index])
    }

    private func parsePosts() {
        posts = deletedService.parseDeleted(posts: posts)
        posts = favoriteService.parseFavorites(posts: posts)
        posts.sort(by: { $0.isFavorite && !$1.isFavorite })
        hasFinishedFetch?()
    }
}
