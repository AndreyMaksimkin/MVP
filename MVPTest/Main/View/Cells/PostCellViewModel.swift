//
//  PostViewModel.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 20/05/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import UIKit

struct PostCellViewModel {
    var text: String?
    var imageURL: String?
    var imageSize = CGSize.zero
    
    init(post: Post) {
        
        for content in post.contents {
            switch content.data {
            case let .text(contentText):
                text = contentText.value
            case let .image(contentImage):
                imageURL = contentImage.extraSmall.url
                let size = contentImage.extraSmall.size
                imageSize = CGSize(width:size.width, height: size.height)
            default:
                break;
            }
        }
    }
}
