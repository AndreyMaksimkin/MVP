//
//  PostDetailsTagsTableViewCell.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 21/05/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import UIKit

final class PostDetailsTagsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: PostDetailsTagsTableViewCell.self)
    
    private let txtlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(txtlabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with data: [String]) {
        txtlabel.text = data.joined(separator: " ")
    }
    
    static func height(for data: [String], containerSize: CGSize) -> CGFloat {
        
        let text = data.joined(separator: " ")
        
        let width = containerSize.width - 2 * Constants.laberHorizontalOffset

        return text.height(with: width,
                           font: UIFont.systemFont(ofSize: 16, weight: .medium))
               + 2 * Constants.labelVerticalOffset
    }
}

private extension PostDetailsTagsTableViewCell {
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            txtlabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.laberHorizontalOffset),
            txtlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.laberHorizontalOffset),
            txtlabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.labelVerticalOffset),
            txtlabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.labelVerticalOffset)
        ])
    }
    
    enum Constants {
        static let labelVerticalOffset: CGFloat = 10
        static let laberHorizontalOffset: CGFloat = 15
    }
}
