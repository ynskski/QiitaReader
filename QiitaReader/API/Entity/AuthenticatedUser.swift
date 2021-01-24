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
    var profileImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileImageURL = "profile_image_url"
    }
}
