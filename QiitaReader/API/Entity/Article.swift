//
//  Article.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import Foundation

struct Article: Decodable, Identifiable {
    var id: String
    var createdAt: String
    var tags: [Tag]
    var title: String
    var likesCount: Int
    var url: String
    var user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case tags
        case title
        case likesCount = "likes_count"
        case url
        case user
    }
    
    struct User: Decodable, Identifiable {
        var id: String
        var name: String
        var profileImageURL: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case profileImageURL = "profile_image_url"
        }
    }
    
    struct Tag: Decodable, Hashable {
        var name: String
        
        enum CodingKeys: String, CodingKey {
            case name
        }
    }
}
