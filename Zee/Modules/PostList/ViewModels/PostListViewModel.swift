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
}

final class PostListViewModel: PostListModel {

    var router: PostListRouterProtocol
    var service: PostServiceProtocol
    private var posts: [Post] = []

    var title: String { "Posts List"}
    var numberOfPosts: Int { return posts.count }

    //Bindings
    var hasFinishedFetch: (() -> Void)?

    init(router: PostListRouterProtocol, service: PostServiceProtocol = PostService()) {
        self.router = router
        self.service = service
    }

    @MainActor
    func fetch() async throws {
        posts = try await service.listAllPosts()
        hasFinishedFetch?()
    }

    func post(for index: Int) -> Post { posts[index] }

    func didSelectPost(at index: Int) {
        router.presentDetailsForPost(posts[index])
    }
}
