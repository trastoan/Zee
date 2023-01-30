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

    private let postDetails: PostDetailsView = {
        let details = PostDetailsView(frame: .zero)
        details.translatesAutoresizingMaskIntoConstraints = false
        return details
    }()

    private let loadingIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        title = model.title
        setupBinding()
        setupSubviews()
        setupConstraints()

        animateLoadIndicator(isLoading: true)

        Task {
            try await model.loadExtraInformation()
        }
    }

    private func setupBinding() {
        model.didFinishLoadingDetails = { [weak self] in
            self?.animateLoadIndicator(isLoading: false)
            self?.setupAllDetails()
        }
    }

    private func setupAllDetails() {
        postDetails.setup(with: model.post)
    }

    private func setupSubviews() {
        view.addSubview(postDetails)
    }

    private func setupConstraints() {
        loadingIndicator.setupOn(view: view)

        NSLayoutConstraint.activate([
            postDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postDetails.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func animateLoadIndicator(isLoading: Bool) {
        if isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
}
