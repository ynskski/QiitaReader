//
//  AuthenticatedUser.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import Foundation

struct AuthenticatedUser: Decodable, Identifiable {
    var id: String
    var name: String
    var githubId: String?
    var twitterId: String?
    var description: String
    var itemsCount: Int
    var followeesCount: Int
    var followersCount: Int
    var profileImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case githubId = "github_login_name"
        case twitterId = "twitter_screen_name"
        case description
        case itemsCount = "items_count"
        case followeesCount = "followees_count"
        case followersCount = "followers_count"
        case profileImageURL = "profile_image_url"
    }
}
