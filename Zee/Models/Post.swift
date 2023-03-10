//
//  Post.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import Foundation

struct Post: Codable, Equatable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    var isFavorite: Bool

    init(post: Post, isFavorite: Bool) {
        self.userId = post.userId
        self.id = post.id
        self.title = post.title
        self.body = post.body
        self.isFavorite = isFavorite
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
        self.isFavorite = false
    }
}
