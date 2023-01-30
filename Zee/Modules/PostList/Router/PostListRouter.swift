//
//  PostListRouter.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//
import UIKit

protocol PostListRouterProtocol {
    static func assembleModule() -> UIViewController
    func presentDetailsForPost(_ post: Post)
}

final class PostListRouter: PostListRouterProtocol {
    private weak var viewController: UIViewController?

    static func assembleModule() -> UIViewController {
        let router = PostListRouter()
        let model = PostListViewModel(router: router)
        let controller = PostListViewController()

        controller.model = model
        router.viewController = controller

        let nav = UINavigationController(rootViewController: controller)
        return nav
    }

    func presentDetailsForPost(_ post: Post) {
        //MARK: TODO
    }
}
