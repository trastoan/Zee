//
//  PostListViewController.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import UIKit

protocol PostListView {
    var model: PostListModel! { get }
}

class PostListViewController: UIViewController, PostListView {
    var model: PostListModel!

    private let postTable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PostListTableViewCell.self, forCellReuseIdentifier: PostListTableViewCell.reuseIdentifier)
        return table
    }()

    private let loadingIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = model.title
        view.backgroundColor = .systemBackground

        setupTable()
        setupDeleteAllButton()
        setupModelCallback()

        animateLoadIndicator(isLoading: true)

        Task {
            try await model.fetch()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        model.viewDidAppear()
    }

    private func setupModelCallback() {
        model.hasFinishedFetch = { [weak self] in
            self?.postTable.reloadData()
            self?.animateLoadIndicator(isLoading: false)
        }
    }

    private func setupDeleteAllButton() {
        let action = UIAction { [weak self] _ in
            self?.model.deleteAllPosts()
        }

        let button = UIBarButtonItem(title: "Delete all", primaryAction: action)

        navigationItem.rightBarButtonItem = button
    }

    private func setupTable() {
        postTable.delegate = self
        postTable.dataSource = self
        postTable.separatorStyle = .singleLine
        postTable.tableFooterView = UIView()
        
        postTable.rowHeight = UITableView.automaticDimension
        postTable.estimatedRowHeight = 44

        setupSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        view.addSubview(postTable)
    }

    private func setupConstraints() {
        loadingIndicator.setupOn(view: view)
        postTable.centerOn(view: view)
    }

    private func animateLoadIndicator(isLoading: Bool) {
        if isLoading {
            postTable.isHidden = true
            loadingIndicator.startAnimating()
        } else {
            postTable.isHidden = false
            loadingIndicator.stopAnimating()
        }
    }
}

extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfPosts
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as PostListTableViewCell
        cell.setup(model.post(for: indexPath.row))

        return cell
    }
}

extension PostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.didSelectPost(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.deletePost(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

