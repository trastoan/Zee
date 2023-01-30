//
//  PostDetailsRouter.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import UIKit

protocol PostDetailsRouterProtocol {
    static func assembleModule(for post: Post) -> UIViewController
}

class PostDetailsRouter: PostDetailsRouterProtocol {
    static func assembleModule(for post: Post) -> UIViewController {
        let controller = PostDetailsViewController()
        let model = PostDetailViewModel(post: post)
        controller.model = model
        
        return controller
    }
}
