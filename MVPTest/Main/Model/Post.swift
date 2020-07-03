//
//  Person.swift
//  MVPTest
//
//  Created by Andrey Maksimkin on 30/01/2020.
//  Copyright © 2020 Andrey Maksimkin. All rights reserved.
//

import Foundation

struct DataResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case data
    }
    let data: Item?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let data = try? values.decode(Item.self, forKey: .data) {
            self.data = data
        } else {
            data = nil
        }
    }
}

struct Item: Decodable {
    let items: [Post]
    var cursor: String
}

struct Post: Decodable {
    let id: String
    let contents: [Content]
}

struct Content: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case type
        case data
    }
    
    let type: String
    let data: PostType
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        type = try values.decode(String.self, forKey: .type)

        if let value = try? values.decode(ContentImage.self, forKey: .data) {
            data = .image(value)
            return
        }

        if let value = try? values.decode(ContentText.self, forKey: .data) {
            data = .text(value)
            return
        }

        if let value = try? values.decode(ContentTag.self, forKey: .data) {
            data = .tags(value)
            return
        }
        
        data = .none
    }
}

struct ContentText: Decodable {
    let value: String
}

struct ContentImage: Decodable {
    let extraSmall: ImageMain
    let small: ImageMain
}
struct ImageSize: Decodable {
    let width: Int
    let height: Int
}
struct ImageMain: Decodable {
    let url: String
    let size: ImageSize
}

struct ContentTag: Decodable {
    let values: [String]
}

enum PostType {
    case image(ContentImage)
    case text(ContentText)
    case tags(ContentTag)
    case none
}
