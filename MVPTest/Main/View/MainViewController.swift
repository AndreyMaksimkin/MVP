//
//  ViewController.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 30/01/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .white
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    var presenter: MainViewPresenterProtocol!
    
    private var viewModels = [PostCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        title = "Posts"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setConstraints()
    }
}

extension MainViewController: UITableViewDataSource & UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: viewModels[indexPath.row])
        
//        if indexPath.row == viewModels.count - 1 {
//            presenter.loadPosts()
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        PostTableViewCell.height(for: viewModels[indexPath.row], containerSize: tableView.frame.size)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tapOnPost(post: presenter.posts[indexPath.row])
    }
    
    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {

        if indexPath.row == viewModels.count - 1 {
            presenter.loadPosts()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
        {
            presenter.loadPosts()
        }
    }
}

extension MainViewController: MainViewProtocol {
    func success(viewModels: [PostCellViewModel]) {
        self.viewModels.append(contentsOf: viewModels)
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

private extension MainViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

