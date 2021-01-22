//
//  APIClient.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import Combine
import UIKit

protocol APIClient {
    func fetchArticle(page: Int) -> AnyPublisher<[Article], Error>
    func fetchProfileImage(url: URL) -> AnyPublisher<UIImage, Error>
}
