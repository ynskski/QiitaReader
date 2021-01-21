//
//  ErrorResponseBody.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import Foundation

struct ErrorResponseBody: Decodable {
    let message: String
    let type: String
}
