//
//  PostListTableViewCell.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import UIKit

class PostListTableViewCell: UITableViewCell {

    let postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .bold)
        return label
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        self.postTitleLabel.text = ""
    }

    func setup(_ post: Post) {
        self.selectionStyle = .none
        postTitleLabel.text = post.title
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("No interface builder is used")
    }

    private func setupSubviews() {
        contentView.addSubview(postTitleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            postTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            postTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
