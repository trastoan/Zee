//
//  PostDetailsViewController.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import UIKit

protocol PostDetailsController {
    var model: PostDetailModel! { get }
}

class PostDetailsViewController: UIViewController, PostDetailsController {
    var model: PostDetailModel!

    private let loadingIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = model.title
        setupBinding()

        animateLoadIndicator(isLoading: true)

        Task {
            try await model.loadExtraInformation()
        }
    }

    private func setupBinding() {
        model.didFinishLoadingDetails = { [weak self] in
            self?.animateLoadIndicator(isLoading: false)
        }
    }

    private func animateLoadIndicator(isLoading: Bool) {
        if isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}
