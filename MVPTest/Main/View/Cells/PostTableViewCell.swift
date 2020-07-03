//
//  PostTableViewCell.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 20/05/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    typealias Data = PostCellViewModel
    
    static let reuseIdentifier = String(describing: PostTableViewCell.self)
    
    private let txtlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 3
        return label
    }()
    
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
        contentView.addSubview(txtlabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with data: PostCellViewModel) {
        txtlabel.text = data.text
        imgView.downloadFrom(link: data.imageURL)
    }
    
    static func height(for data: Data, containerSize: CGSize) -> CGFloat {
        let imageHeight = 2 * Constants.imgViewVerticalOffset
            + Constants.imgViewDefaultSize.height
        
        let width = containerSize.width
            - 2 * Constants.laberHorizontalOffset
            - 2 * Constants.imgViewLeftOffset
            - Constants.imgViewDefaultSize.width
        
        guard let text = data.text else {
            return imageHeight
        }
        
        let labelHeight = text.height(with: width,
                                      font: UIFont.systemFont(ofSize: 14, weight: .regular)) + 2 * Constants.labelVerticalOffset
        
        return max(imageHeight, min(labelHeight, Constants.maxLabelHeight))
    }
}

private extension PostTableViewCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.imgViewLeftOffset),
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.imgViewVerticalOffset),
            imgView.widthAnchor.constraint(equalToConstant: Constants.imgViewDefaultSize.width),
            imgView.heightAnchor.constraint(equalToConstant: Constants.imgViewDefaultSize.height),
            
            txtlabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: Constants.laberHorizontalOffset),
            txtlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.laberHorizontalOffset),
            txtlabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.labelVerticalOffset),
            txtlabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.labelVerticalOffset)
        ])
    }
    
    enum Constants {
        static let imgViewLeftOffset: CGFloat = 15
        static let imgViewVerticalOffset: CGFloat = 12
        static let imgViewDefaultSize = CGSize(width: 60, height: 60)
        static let labelVerticalOffset: CGFloat = 10
        static let laberHorizontalOffset: CGFloat = 15
        static let maxLabelHeight: CGFloat = 50
    }
}
