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
    func presentAlertForAllPostDeletion(completion: @escaping () -> ())
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
        let destination = PostDetailsRouter.assembleModule(for: post)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }

    func presentAlertForAllPostDeletion(completion: @escaping () -> ()) {
        let alert = UIAlertController(title: "Deleting All Posts", message: "Do you wish to delete all posts except the favorite ones?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
            completion()
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(confirmAction)

        viewController?.present(alert, animated: true)
    }
}
