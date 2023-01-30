//
//  Comment.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import Foundation

struct Comment: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
