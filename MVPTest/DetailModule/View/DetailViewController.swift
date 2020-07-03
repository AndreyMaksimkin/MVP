//
//  DetailViewController.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 30/01/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        tableView.register(PostDetailsImageTableViewCell.self, forCellReuseIdentifier: PostDetailsImageTableViewCell.reuseIdentifier)
        tableView.register(PostDetailsTextTableViewCell.self, forCellReuseIdentifier: PostDetailsTextTableViewCell.reuseIdentifier)
        tableView.register(PostDetailsTagsTableViewCell.self, forCellReuseIdentifier: PostDetailsTagsTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    var presenter: DetailViewPresenterProtocol!
    
    private var viewModels = [PostDetailsViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setConstraints()
    }
}

extension DetailViewController: UITableViewDataSource & UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = viewModels[indexPath.row]
        
        switch viewModel {
        case let .image(postDetailsImage):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailsImageTableViewCell.reuseIdentifier, for: indexPath) as? PostDetailsImageTableViewCell else {
                return UITableViewCell()
            }

            cell.setup(with: postDetailsImage)
            return cell
            
        case let .text(string):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailsTextTableViewCell.reuseIdentifier, for: indexPath) as? PostDetailsTextTableViewCell else {
                return UITableViewCell()
            }

            cell.setup(with: string)
            return cell
            
        case let .tags(strings):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailsTagsTableViewCell.reuseIdentifier, for: indexPath) as? PostDetailsTagsTableViewCell else {
                return UITableViewCell()
            }

            cell.setup(with: strings)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = viewModels[indexPath.row]
        let containerSize = tableView.frame.size
        
        switch viewModel {
        case let .image(postDetailsImage):
            return PostDetailsImageTableViewCell.height(for: postDetailsImage, containerSize: containerSize)
            
        case let .text(string):
            return PostDetailsTextTableViewCell.height(for: string, containerSize: containerSize)
            
        case let .tags(strings):
            return PostDetailsTagsTableViewCell.height(for: strings, containerSize: containerSize)
        }
    }
}


extension DetailViewController: DetailViewProtocol {
    func setPost(details: [PostDetailsViewModel]) {
        viewModels = details
        tableView.reloadData()
    }
}

private extension DetailViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
