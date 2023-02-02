//
//  PostListSpies.swift
//  ZeeTests
//
//  Created by Yuri on 02/02/23.
//

import UIKit
@testable import Zee

final class PostListServiceMock: PostServiceProtocol {
    func listAllPosts() async throws -> [Zee.Post] { PostFixtures.postsArray() }
}

final class PostListRouterSpy: PostListRouterProtocol {
    var hasPresentDetailsForPost = false
    var hasPresentedAlertForDelete = false

    static func assembleModule() -> UIViewController {
        UIViewController()
    }

    func presentDetailsForPost(_ post: Zee.Post) {
        hasPresentDetailsForPost = true
    }

    func presentAlertForAllPostDeletion(completion: @escaping () -> ()) {
        hasPresentedAlertForDelete = true
        completion()
    }
}
