//
//  UserAuthenticator.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/24.
//

import Foundation
import KeychainAccess

struct UserAuthenticator {
    private init() {}

    private static let keychain = Keychain()
    static var authenticationCode: String?
    static var accessToken: String? {
        get {
            do {
                if let token = try keychain.get("QiitaReaderToken") {
                    return token
                }
                return nil
            } catch {
                return nil
            }
        }
        
        set {
            if let token = newValue {
                keychain.accessibility(.whenUnlockedThisDeviceOnly)["QiitaReaderToken"] = token
                print("###", token)
            }
        }
    }
    static var authenticatedUser: AuthenticatedUser?
}
