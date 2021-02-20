//
//  UserAuthenticator.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/24.
//

import Foundation

struct UserAuthenticator {
    private init() {}

    static var authenticationCode: String?
    static var accessToken: String?
    static var authenticatedUser: AuthenticatedUser?
}
