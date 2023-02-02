//
//  FavoritesServiceTest.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import XCTest
@testable import Zee

final class FavoritesServiceTest: XCTestCase {
    private var sut: FavoriteServices!
    private var userDefaults: UserDefaults!
    private var posts: [Post]!

    override func setUp() {
        userDefaults = UserDefaults(suiteName: #file)!
        sut = FavoriteServices(userDefaults: userDefaults)
        posts = PostFixtures.postsArray()
    }

    override func tearDown() {
        sut = nil
        userDefaults.removePersistentDomain(forName: #file)
    }

    func testFavorites_atFirst_shouldBeEmpty() {
        let parsed = sut.parseFavorites(posts: posts)
        let favorites = parsed.filter { $0.isFavorite == true }

        XCTAssertEqual(favorites.count, 0)
    }

    func testFavoriteParse_whenThereIsFavorites_shouldReturnPostWithFavorites() {
        sut.addToFavorites(post: posts.first!)

        let parsed = sut.parseFavorites(posts: posts)
        let favorites = parsed.filter { $0.isFavorite == true }

        XCTAssertEqual(favorites.count, 1)
    }


    func testFavorites_whenRemovingFavorites_shouldNotReturnPostWithFavorite() {
        sut.addToFavorites(post: posts.first!)

        let parsed = sut.parseFavorites(posts: posts)
        let favorites = parsed.filter { $0.isFavorite == true }

        XCTAssertEqual(favorites.count, 1)

        sut.removeFromFavorites(post: posts.first!)

        let noFavoritesParsed = sut.parseFavorites(posts: posts)
        let noFavorites = noFavoritesParsed.filter { $0.isFavorite == true }

        XCTAssertEqual(noFavorites.count, 0)
    }

}
