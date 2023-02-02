//
//  PostDetailsViewModelTests.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import XCTest
@testable import Zee


final class PostDetailsViewModelTests: XCTestCase {
    private var sut: PostDetailViewModel!
    private var userDefaults: UserDefaults!
    private var mockCommentService: CommentServiceProtocol!
    private var mockUserService: UserServiceProtocol!
    private var mockFavoriteService: FavoriteServices!

    override func setUp() {
        userDefaults = UserDefaults(suiteName: #file)!
        mockCommentService = MockedCommentService()
        mockUserService = MockedUserService()
        mockFavoriteService = FavoriteServices(userDefaults: userDefaults)
        sut = PostDetailViewModel(post: PostFixtures.post(), userService: mockUserService, commentService: mockCommentService, favoriteService: mockFavoriteService)
    }

    override func tearDown() {
        mockCommentService = nil
        mockUserService = nil
        mockFavoriteService = nil
        sut = nil
        userDefaults.removePersistentDomain(forName: #file)
    }

    func test_titleShouldBe_details() {
        XCTAssertEqual(sut.title, "Details")
    }

    func test_loadExtraInfo_getsCommentsAndUser() async throws {
        try await sut.loadExtraInformation()
        XCTAssertNotNil(sut.user)
        XCTAssertEqual(sut.comments.count, 2)
    }

    func test_changeFavoriteStatus_favoritesPost() {
        sut.changeFavoriteStatus()
        XCTAssertTrue(sut.post.isFavorite)
    }

    func test_whenFavoriteChangeStatus_unfavorite() {
        sut.changeFavoriteStatus()
        XCTAssertTrue(sut.post.isFavorite)

        sut.changeFavoriteStatus()
        XCTAssertFalse(sut.post.isFavorite)
    }
}
