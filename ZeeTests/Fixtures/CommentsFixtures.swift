//
//  CommentsFixtures.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import Foundation
@testable import Zee

struct CommentsFixture {
    static func commentsList() -> [Comment] { JsonLoader().loadJson(named: "Comments")! }
}
