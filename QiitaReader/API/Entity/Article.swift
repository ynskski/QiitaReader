//
//  Article.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import Foundation

struct Article: Decodable, Identifiable {
    var id: String
    var title: String
    var likesCount: Int
    var url: String
    var user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case likesCount = "likes_count"
        case url
        case user
    }
}
