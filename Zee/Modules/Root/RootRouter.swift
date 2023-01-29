//
//  RootRouter.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import UIKit

protocol RootRouterProtocol {
    static func presentEntryController(in window: UIWindow)
}

class RootRouter {
    static func presentEntryController(in window: UIWindow) {
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
    }
}

