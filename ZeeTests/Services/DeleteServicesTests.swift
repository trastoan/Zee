//
//  DeleteServicesTests.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import XCTest
@testable import Zee

final class DeleteServicesTests: XCTestCase {
    private var sut: DeleteService!
    private var userDefaults: UserDefaults!
    private var mockedPosts: [Post]!

    override func setUp() {
        userDefaults = UserDefaults(suiteName: #file)!
        sut = DeleteService(userDefaults: userDefaults)
        mockedPosts = PostFixtures.postsArray()
    }

    override func tearDown() {
        sut = nil
        mockedPosts = nil
        userDefaults.removePersistentDomain(forName: #file)
    }

    func test_atFirst_shouldBeEmpty() {
        let parsed = sut.parseDeleted(posts: mockedPosts)

        XCTAssertEqual(parsed.count, mockedPosts.count)
    }

    func test_whenPostDeleted_shouldRemoveFromArray() {
        sut.addToDeleted(post: mockedPosts.first!)

        let parsed = sut.parseDeleted(posts: mockedPosts)

        XCTAssertEqual(parsed.count, mockedPosts.count - 1)
    }

    func test_whenDeletedAll_noPostShouldBeReturned() {
        sut.deleteAll(posts: mockedPosts)

        let parsed = sut.parseDeleted(posts: mockedPosts)

        XCTAssertEqual(parsed.count, 0)
    }

    func test_whenRestoringAll_allPostShouldBeReturn() {
        sut.deleteAll(posts: mockedPosts)

        let deletedParsed = sut.parseDeleted(posts: mockedPosts)

        XCTAssertEqual(deletedParsed.count, 0)

        sut.restoreAll()

        let restoredParsed = sut.parseDeleted(posts: mockedPosts)

        XCTAssertEqual(restoredParsed.count, mockedPosts.count)
    }
}
