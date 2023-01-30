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

    private let userDetails: UserInfoView = {
        let details = UserInfoView(frame: .zero)
        details.isHidden = true
        details.translatesAutoresizingMaskIntoConstraints = false
        return details
    }()

    private let commentsList: CommentsView = {
        let comments = CommentsView(frame: .zero)
        comments.isHidden = true
        comments.translatesAutoresizingMaskIntoConstraints = false
        return comments
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
        if model.comments.count > 0 {
            commentsList.setup(with: model.comments)
            commentsList.isHidden = false
        }
        if let user = model.user {
            userDetails.isHidden = false
            userDetails.setup(with: user)
        }
    }

    private func setupSubviews() {
        view.addSubview(postDetails)
        view.addSubview(userDetails)
        view.addSubview(commentsList)
    }

    private func setupConstraints() {
        loadingIndicator.setupOn(view: view)

        NSLayoutConstraint.activate([
            postDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            postDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postDetails.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            userDetails.topAnchor.constraint(equalTo: postDetails.bottomAnchor, constant: 18),
            userDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            userDetails.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            commentsList.topAnchor.constraint(equalTo: userDetails.bottomAnchor, constant: 18),
            commentsList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            commentsList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            commentsList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
