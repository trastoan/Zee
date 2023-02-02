//
//  PostFixtures.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import Foundation
@testable import Zee

struct PostFixtures {
    static func postsArray() -> [Post] {
        JsonLoader().loadJson(named: "Posts")!
    }
}
