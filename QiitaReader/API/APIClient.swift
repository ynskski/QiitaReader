//
//  APIClient.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import Combine
import UIKit

protocol APIClient {
    func fetchAccessToken(code: String) -> AnyPublisher<AccessTokenResponseBody, Error>
    func fetchAuthenticatedUser(token: String) -> AnyPublisher<AuthenticatedUser, Error>
    func fetchArticle(page: Int, query: String) -> AnyPublisher<[Article], Error>
    func fetchAuthenticatedUserItems(page: Int) -> AnyPublisher<[Article], Error>
    func fetchProfileImage(url: URL) -> AnyPublisher<UIImage, Error>
}
