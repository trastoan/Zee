//
//  CommentsView.swift
//  Zee
//
//  Created by Yuri on 30/01/23.
//

import UIKit

class CommentsView: UIView {
    private let commentsSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 22, weight: .bold)
        return label
    }()

    private let commentsTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)
        return table
    }()

    private var comments: [Comment] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
        setupTable()
    }

    required init?(coder: NSCoder) {
        fatalError("No interface builder is used")
    }

    func setup(with comments: [Comment]) {
        self.comments = comments
        commentsTable.reloadData()
    }

    private func setupTable() {
        commentsTable.dataSource = self
        commentsTable.separatorStyle = .none
        commentsTable.tableFooterView = UIView()

        commentsTable.rowHeight = UITableView.automaticDimension
        commentsTable.estimatedRowHeight = 44
    }

    private func setupSubviews() {
        self.addSubview(commentsSectionLabel)
        self.addSubview(commentsTable)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            commentsSectionLabel.topAnchor.constraint(equalTo: self.topAnchor),
            commentsSectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            commentsSectionLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -18),

            commentsTable.topAnchor.constraint(equalTo: commentsSectionLabel.bottomAnchor, constant: 8),
            commentsTable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            commentsTable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            commentsTable.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension CommentsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CommentTableViewCell
        cell.setup(comments[indexPath.row])

        return cell
    }
}
