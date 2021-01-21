//
//  APIClient.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import Combine

protocol APIClient {
    func fetchArticle(page: Int) -> AnyPublisher<[Article], Error>
}
