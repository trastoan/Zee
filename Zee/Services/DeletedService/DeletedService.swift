//
//  DeletedService.swift
//  Zee
//
//  Created by Yuri on 31/01/23.
//

import Foundation

protocol DeleteServiceProtocol {
    func addToDeleted(post: Post)
    func removeFromDeleted(post: Post)
    func parseDeleted(posts: [Post]) -> [Post]
    func restoreAll()
    func deleteAll(posts: [Post])
}

class DeleteService: DeleteServiceProtocol {

    var userDefaults: UserDefaults

    private let deletedIDKey = "deletedIDList"

    private var deletedID: [Int] {
        get { userDefaults.array(forKey: deletedIDKey) as? [Int] ?? [] }
        set { userDefaults.setValue(newValue, forKey: deletedIDKey) }
    }

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func addToDeleted(post: Post) {
        deletedID.append(post.id)
    }

    func removeFromDeleted(post: Post) {
        deletedID.removeAll(where: { $0 == post.id })
    }

    func parseDeleted(posts: [Post]) -> [Post] {
        let deleted = deletedID
        return posts.filter { !deleted.contains($0.id) }
    }

    func restoreAll() {
        deletedID = []
    }

    func deleteAll(posts: [Post]) {
        posts.forEach {
            if $0.isFavorite == false { addToDeleted(post: $0) }
        }
    }

}
