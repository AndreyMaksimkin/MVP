//
//  UIImageViewExtension.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 21/05/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadFrom(link: String?) {
        image = UIImage(named: "default")
        
        guard let link = link, let url = URL(string: link) else {
            image = UIImage(named: "default")
            return
        }
        
        URLSession.shared.dataTask(with: url as URL) { data, response, error in
            guard let data = data, error == nil else {
                print("\nerror on download \(String(describing: error))")
            return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("statusCode != 200; \(httpResponse.statusCode)")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = UIImage(data: data)
                
            }
        }.resume()
    }
}
