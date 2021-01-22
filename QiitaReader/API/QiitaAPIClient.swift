//
//  QiitaAPIClient.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import Combine
import Foundation

final class QiitaAPIClient: APIClient {
    private(set) static var shared: QiitaAPIClient = .init(baseURL: "https://qiita.com/api/v2")
    
    let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func fetchArticle(page: Int) -> AnyPublisher<[Article], Error> {
        var urlComponents = URLComponents(string: "\(baseURL)/items")!
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: "50")
        ]
        urlComponents.queryItems = queryItems
        let request = URLRequest(url: urlComponents.url!)
        
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                try self.throwResponseError(response, data: data)
                return data
            }
            .decode(type: [Article].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func throwResponseError(_ response: URLResponse, data: Data) throws {
        if let response = response as? HTTPURLResponse {
            if !(200...204).contains(response.statusCode) {
                if let decoded = try? JSONDecoder().decode(ErrorResponseBody.self, from: data) {
                    throw APIClientError.message(decoded.message, decoded.type, response.statusCode)
                }
                
                throw APIClientError.unexpectedStatusCode(response.statusCode)
            }
        }
    }
}