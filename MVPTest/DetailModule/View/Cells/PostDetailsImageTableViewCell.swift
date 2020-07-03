//
//  PostDetailsTableViewCell.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 21/05/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import UIKit

final class PostDetailsImageTableViewCell: UITableViewCell {
    
    typealias Data = PostDetailsImageCellViewModel
    
    static let reuseIdentifier = String(describing: PostDetailsImageTableViewCell.self)
    
    private let imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "default")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(imgView)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with data: PostDetailsImageCellViewModel) {
        imgView.downloadFrom(link: data.imageURL)
    }
    
    static func height(for data: Data, containerSize: CGSize) -> CGFloat {
        let imageWidth = min(containerSize.width - 2 * Constants.imgViewHorizontalOffset, data.imageSize.width)
        
        let imageHeight = data.imageSize.height * imageWidth / data.imageSize.width

        return imageHeight + 2 * Constants.imgViewVerticalOffset
    }
}

private extension PostDetailsImageTableViewCell {
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.imgViewHorizontalOffset),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.imgViewHorizontalOffset),
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.imgViewVerticalOffset),
            imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.imgViewVerticalOffset),
        ])
    }
    
    enum Constants {
        static let imgViewHorizontalOffset: CGFloat = 15
        static let imgViewVerticalOffset: CGFloat = 12
        static let imgViewDefaultSize = CGSize(width: 90, height: 90)
    }
}
