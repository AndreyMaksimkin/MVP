//
//  StringExtension.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 20/05/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import UIKit

extension String {
    func height(with width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }
}
