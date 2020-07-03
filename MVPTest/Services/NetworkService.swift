//
//  NetworkService.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 30/01/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getPosts(limit: Int, after: String?, completion: @escaping (Result<Item?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    let urlString = "http://stage.apianon.ru:3000/fs-posts/v1/posts"
    
    func getPosts(limit: Int, after: String?, completion: @escaping (Result<Item?, Error>) -> Void) {
        
        var result = urlString
        result += "?first=\(20)"
        
        if let after = after {
            let str = after.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            result += "&after=\(str!)"
        }
        
        guard let url =  URL(string: result) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(DataResponse.self, from: data!)
                completion(.success(obj.data))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
