//
//  FavoritesService.swift
//  Zee
//
//  Created by Yuri on 31/01/23.
//

import Foundation

class FavoriteServices {
    var userDefaults: UserDefaults

    let favoritesIDKey = "favoriteIDList"

    private var favoritesID: [Int] {
        get { userDefaults.array(forKey: favoritesIDKey) as! [Int] }
        set { userDefaults.setValue(newValue, forKey: favoritesIDKey) }
    }

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func addToFavorites(post: Post) {
        favoritesID.append(post.id)
    }

    func removeFromFavorites(post: Post) {
        favoritesID.removeAll(where: { $0 == post.id })
    }

    func parseFavorites(posts: [Post]) -> [Post] {
        var parsed = [Post]()
        let favorites = favoritesID
        posts.forEach {
            if favorites.contains($0.id) {
                parsed.append(Post(post: $0, isFavorite: true))
            } else {
                parsed.append($0)
            }
        }

        return parsed
    }
}
