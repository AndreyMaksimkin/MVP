//
//  MainPresenter.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 30/01/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    func success(viewModels: [PostCellViewModel])
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func loadPosts()
    func tapOnPost(post: Post)
    var posts: [Post] { get }
}

final class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol
    var posts = [Post]()
    var after: String?
    
    var isLoading = false
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        
        loadPosts()
    }
    
    func loadPosts() {
        
        guard isLoading == false else {
            return
        }
        
        isLoading = true
        
        networkService.getPosts(limit: 20, after: after, completion: { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.isLoading = false
                
                switch result {
                case let .success(item):
                    self.after = item?.cursor
                    if let newPosts = item?.items {
                        self.posts.append(contentsOf: newPosts)
                        self.view?.success(viewModels: newPosts.map { PostCellViewModel(post: $0) })
                    }
                
                case let .failure(error):
                    self.view?.failure(error: error)
                }
            }
        })
    }
    
    func tapOnPost(post: Post) {
        router?.showDetail(post: post)
    }
}
