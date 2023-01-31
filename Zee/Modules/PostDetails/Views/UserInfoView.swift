//
//  UserInfoView.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import UIKit

class UserInfoView: UIView {

    //MARK: Labels
    private let authorSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 22, weight: .bold)
        return label
    }()

    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .regular)
        return label
    }()

    private let companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .regular)
        return label
    }()

    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .regular)
        return label
    }()

    //MARK: Stacks

    private lazy var iconStacks: UIStackView = {
        let userIcon = imageForIcon(systemName: "person.circle.fill")
        let addressIcon = imageForIcon(systemName: "house.fill")
        let companyIcon = imageForIcon(systemName: "building.2.fill")

        let stack = UIStackView(arrangedSubviews: [userIcon, addressIcon, companyIcon])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var labelStacks: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [authorNameLabel, addressLabel, companyLabel])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconStacks])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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

    func setup(with user: User) {
        authorNameLabel.text = user.name
        addressLabel.text = "\(user.address.street) - \(user.address.city)"
        companyLabel.text = user.company.name

        infoStack.addArrangedSubview(labelStacks)
    }

    private func setupSubviews() {
        self.addSubview(authorSectionLabel)
        self.addSubview(infoStack)
    }

    private func imageForIcon(systemName: String) -> UIImageView {
        let icon = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(systemName: systemName)
        return icon
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authorSectionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            authorSectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            authorSectionLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -18),

            infoStack.topAnchor.constraint(equalTo: authorSectionLabel.bottomAnchor, constant: 8),
            infoStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            infoStack.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -18),
            infoStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
