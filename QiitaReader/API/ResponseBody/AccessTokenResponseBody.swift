//
//  AccessTokenResponseBody.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/24.
//

import Foundation

struct AccessTokenResponseBody: Decodable {
    let client_id: String
    let scopes: [String]
    let token: String
}
