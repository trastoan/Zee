//
//  CommentTableViewCell.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    override var frame: CGRect {
        didSet {
            shadowView.dropShadow()
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.font(named: "Helvetica", size: 18, weight: .bold)
        return label
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .semibold)
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .regular)
        return label
    }()

    let shadowView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        bodyLabel.text = ""
        emailLabel.text = ""
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            shadowView.dropShadow(force: true)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

    func setup(_ comment: Comment) {
        self.selectionStyle = .none
        titleLabel.text = comment.name.capitalizedFirstLetter
        bodyLabel.text = comment.body.capitalizedFirstLetter
        emailLabel.text = comment.email.lowercased()
    }

    private func setupSubviews() {
        shadowView.addSubview(titleLabel)
        shadowView.addSubview(bodyLabel)
        shadowView.addSubview(emailLabel)
        contentView.addSubview(shadowView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            titleLabel.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -10),

            emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 10),
            emailLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -10),

            bodyLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -10),
            bodyLabel.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -8)
            
        ])
    }
}
