//
//  PostDetailsView.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import UIKit

class PostDetailsView: UIView {

    let postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.font(named: "Helvetica", size: 22, weight: .bold)
        return label
    }()

    let postBodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .regular)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("No interface builder is used")
    }

    func setup(with post: Post) {
        postTitleLabel.text = post.title.capitalizedFirstLetter
        postBodyLabel.text = post.body
    }

    private func setupSubviews() {
        self.addSubview(postTitleLabel)
        self.addSubview(postBodyLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            postTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            postTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),

            postBodyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            postBodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            postBodyLabel.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: 8),
            postBodyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
