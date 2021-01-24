//
//  UserAuthenticator.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/24.
//

import Foundation

struct UserAuthenticator {
    private init() {}
    
    static var authenticationCode: String? = nil
    static var accessToken: String? = nil
    static var authenticatedUser: AuthenticatedUser? = nil
}
