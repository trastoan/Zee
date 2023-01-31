//
//  FavoritesService.swift
//  Zee
//
//  Created by Yuri on 31/01/23.
//

import Foundation

protocol FavoriteServiceProtocol {
    func addToFavorites(post: Post)
    func removeFromFavorites(post: Post)
    func parseFavorites(posts: [Post]) -> [Post]
}

class FavoriteServices: FavoriteServiceProtocol {
    var userDefaults: UserDefaults

    let favoritesIDKey = "favoriteIDList"

    private var favoritesID: [Int] {
        get { userDefaults.array(forKey: favoritesIDKey) as? [Int] ?? [] }
        set { userDefaults.setValue(newValue, forKey: favoritesIDKey) }
    }

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func addToFavorites(post: Post) {
        favoritesID.append(post.id)
    }

    func removeFromFavorites(post: Post) {
        print(favoritesID.count)
        favoritesID.removeAll(where: { $0 == post.id })
        print(favoritesID.count)
    }

    func parseFavorites(posts: [Post]) -> [Post] {
        var parsed = [Post]()
        let favorites = favoritesID
        posts.forEach {
            if favorites.contains($0.id) {
                parsed.append(Post(post: $0, isFavorite: true))
            } else {
                parsed.append(Post(post: $0, isFavorite: false))
            }
        }

        return parsed
    }
}
