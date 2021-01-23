//
//  UserAuthenticator.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/24.
//

import Foundation

struct UserAuthenticator {
    private init() {}
    
    static var oauthUrlString: String {
        let env = ProcessInfo.processInfo.environment
        if let client_id = env["client_id"] {
            return "https://qiita.com/api/v2/oauth/authorize?client_id=\(client_id)&scope=read_qiita"
        } else {
            fatalError("Error: No access token")
        }
    }
    
    static var authenticatedUser: User? = nil
}
