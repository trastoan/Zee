//
//  PostListTableViewCell.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import UIKit

class PostListTableViewCell: UITableViewCell {

    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .bold)
        return label
    }()

    private let starIcon: UIImageView = {
        let icon = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(systemName: "star.fill")
        icon.tintColor = .systemYellow
        icon.isHidden = true
        return icon
    }()

    private var leadingLabelAnchor: NSLayoutConstraint?

    override func prepareForReuse() {
        super.prepareForReuse()
        self.postTitleLabel.text = ""
        adjustConstraintForFavorite(false)
    }

    func setup(_ post: Post) {
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        postTitleLabel.text = post.title.capitalizedFirstLetter
        adjustConstraintForFavorite(post.isFavorite)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("No interface builder is used")
    }

    private func adjustConstraintForFavorite(_ isFavorite: Bool) {
        starIcon.isHidden = !isFavorite
        //Remove old constraint
        leadingLabelAnchor?.isActive = false
        postTitleLabel.removeConstraint(leadingLabelAnchor!)
        //Add new one
        if isFavorite {
            leadingLabelAnchor = postTitleLabel.leadingAnchor.constraint(equalTo: starIcon.trailingAnchor, constant: 8)
        } else {
            leadingLabelAnchor = postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18)
        }
        leadingLabelAnchor?.isActive = true
    }

    private func setupSubviews() {
        contentView.addSubview(postTitleLabel)
        contentView.addSubview(starIcon)
    }

    private func setupConstraints() {
        leadingLabelAnchor = postTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18)

        NSLayoutConstraint.activate([
            leadingLabelAnchor!,
            postTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            postTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            postTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            starIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            starIcon.widthAnchor.constraint(equalToConstant: 20),
            starIcon.heightAnchor.constraint(equalToConstant: 20),
            starIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
        ])
    }
}
