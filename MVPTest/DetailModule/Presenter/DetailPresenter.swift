//
//  DetailPresenter.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 30/01/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import Foundation

//input
protocol DetailViewProtocol: class {
    func setPost(details: [PostDetailsViewModel])
}

//output
protocol DetailViewPresenterProtocol {
    init(view: DetailViewProtocol, router: RouterProtocol, post: Post)
    func tapBack()
}

final class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    var router: RouterProtocol
    let post: Post
    
    required init(view: DetailViewProtocol, router: RouterProtocol, post: Post) {
        self.view = view
        self.router = router
        self.post = post
        
        view.setPost(details: generateViewModels())
    }
    
    func tapBack() {
        router.popToRoot()
    }
}

private extension DetailPresenter {
    func generateViewModels() -> [PostDetailsViewModel] {
        var viewModels = [PostDetailsViewModel]()
        
        for content in post.contents {
            switch content.data {
            case let .text(contentText):
                viewModels.append(.text(contentText.value))
                
            case let .image(contentImage):
                let imageViewModel =
                    PostDetailsImageCellViewModel(imageURL: contentImage.small.url,
                                                  imageSize: contentImage.small.size)
                viewModels.append(.image(imageViewModel))
                
            case let .tags(contentTag):
                viewModels.append(.tags(contentTag.values))
                
            case .none:
                break;
            }
        }
        
        return viewModels
    }
}
