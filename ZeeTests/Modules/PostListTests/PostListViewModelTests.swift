//
//  PostListViewModelTests.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import XCTest
@testable import Zee


final class PostListViewModelTests: XCTestCase {
    private var sut: PostListViewModel!
    private var spyRouter: PostListRouterSpy!
    private var mockService: PostServiceProtocol!
    private var mockDeleteService: DeleteService!
    private var mockFavoriteService: FavoriteServices!
    private var userDefaults: UserDefaults!
    private var hasCalledFinishedFetch = false


    override func setUp() {
        userDefaults = UserDefaults(suiteName: #file)!
        mockService = PostListServiceMock()
        spyRouter = PostListRouterSpy()
        mockDeleteService = DeleteService(userDefaults: userDefaults)
        mockFavoriteService = FavoriteServices(userDefaults: userDefaults)
        sut = PostListViewModel(router: spyRouter, service: mockService,
                                favoriteService: mockFavoriteService,
                                deletedService: mockDeleteService)
        sut.hasFinishedFetch = { [weak self] in self?.hasCalledFinishedFetch = true }
    }

    override func tearDown() {
        sut = nil
        spyRouter = nil
        mockService = nil
        mockDeleteService = nil
        mockFavoriteService = nil
        hasCalledFinishedFetch = false
        userDefaults.removePersistentDomain(forName: #file)
    }

    func test_titleShouldBe_PostList() {
        XCTAssertEqual(sut.title, "Posts List")
    }

    func test_shouldCallFinishFetch_true() async throws {
        try await sut.fetch()
        XCTAssertTrue(hasCalledFinishedFetch)
    }

    func test_fetchShouldReturn_threePosts() async throws {
        try await sut.fetch()
        XCTAssertEqual(sut.numberOfPosts, 3)
    }

    func test_shouldShowPostDetails_true() async throws {
        try await sut.fetch()
        sut.didSelectPost(at: 0)

        XCTAssertTrue(spyRouter.hasPresentDetailsForPost)
    }

    func test_deleteShouldShowAlert_thenRemove() async throws {
        try await sut.fetch()
        XCTAssertEqual(sut.numberOfPosts, 3)

        sut.deletePost(at: 0)
        XCTAssertEqual(sut.numberOfPosts, 2)

        //Post should also not show again after a fetch
        try await sut.fetch()
        XCTAssertEqual(sut.numberOfPosts, 2)
    }

    func test_deleteAllShouldShowAlert_thenDelete() async throws {
        try await sut.fetch()
        XCTAssertEqual(sut.numberOfPosts, 3)

        sut.deleteAllPosts()
        XCTAssertEqual(sut.numberOfPosts, 0)
        XCTAssertTrue(spyRouter.hasPresentedAlertForDelete)

        //Post should also not show again after a fetch
        try await sut.fetch()
        XCTAssertEqual(sut.numberOfPosts, 0)
    }

    func test_deleteAllIgnoresFavorites_deletesTheRest() async throws {
        try await sut.fetch()
        XCTAssertEqual(sut.numberOfPosts, 3)

        mockFavoriteService.addToFavorites(post: sut.post(for: 0))
        sut.deleteAllPosts()
        XCTAssertEqual(sut.numberOfPosts, 1)

        //Post should also not show again after a fetch
        try await sut.fetch()
        XCTAssertEqual(sut.numberOfPosts, 1)
    }

    func test_restoreAllPosts_shouldBringAllBack() async throws {
        try await sut.fetch()
        XCTAssertEqual(sut.numberOfPosts, 3)

        sut.deleteAllPosts()
        XCTAssertEqual(sut.numberOfPosts, 0)

        try await sut.restoreAllPosts()
        XCTAssertEqual(sut.numberOfPosts, 3)
    }

    func test_postsShouldBeOrdered_favoritesFirst() async throws {
        try await sut.fetch()
        XCTAssertEqual(sut.numberOfPosts, 3)

        var favoritePost = sut.post(for: 2)
        favoritePost.isFavorite = true

        mockFavoriteService.addToFavorites(post: sut.post(for: 2))
        try await sut.fetch()
        XCTAssertEqual(sut.post(for: 0), favoritePost)
    }
}
