//
//  QiitaAPIClient.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import Combine
import Foundation
import UIKit

final class QiitaAPIClient: APIClient {
    private(set) static var shared: QiitaAPIClient = .init(baseURL: "https://qiita.com/api/v2")
    
    let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    static var oauthUrlString: String {
        let env = ProcessInfo.processInfo.environment
        if let client_id = env["client_id"] {
            return "https://qiita.com/api/v2/oauth/authorize?client_id=\(client_id)&scope=read_qiita"
        } else {
            fatalError("Error: No access token")
        }
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
    
    func fetchArticle(page: Int, query: String) -> AnyPublisher<[Article], Error> {
        var urlComponents = URLComponents(string: "\(baseURL)/items")!
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: "50"),
            URLQueryItem(name: "query", value: query)
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
    
    func fetchProfileImage(url: URL) -> AnyPublisher<UIImage, Error> {
        let request = URLRequest(url: url)
        
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                try self.throwResponseError(response, data: data)
                return UIImage(data: data) ?? UIImage(systemName: "photo")!
            }
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
