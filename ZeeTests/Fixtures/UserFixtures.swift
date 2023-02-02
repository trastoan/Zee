//
//  UserFixtures.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import Foundation
@testable import Zee

struct UserFixture {
    static func user() -> User { JsonLoader().loadJson(named: "User")! }
}
