//
//  PostDetailsCellViewModel.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 21/05/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import UIKit

enum PostDetailsViewModel {
    case image(PostDetailsImageCellViewModel)
    case text(String)
    case tags([String])
}

struct PostDetailsImageCellViewModel {
    let imageURL: String
    let imageSize: CGSize
    
    init(imageURL: String, imageSize: ImageSize) {
        self.imageURL = imageURL
        self.imageSize = CGSize(width: imageSize.width, height: imageSize.height)
    }
}
