//
//  ArticleListViewModel.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import Combine
import Foundation

final class ArticleListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    
    private let qiitaApiClient = QiitaAPIClient.shared
    
    private var cancellables: Set<AnyCancellable> = []
    
    func loadArticles(page: Int) {
        isLoading = true
        
        qiitaApiClient
            .fetchArticle(page: page)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                self.isLoading = false
            }, receiveValue: { articles in
                self.articles += articles
            })
            .store(in: &cancellables)
    }
    
    func loadArticles(page: Int, query: String) {
        isLoading = true
        
        qiitaApiClient
            .fetchArticle(page: page, query: query)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                self.isLoading = false
            }, receiveValue: { articles in
                // TODO: - 追加の方法を考える
                self.articles = articles
            })
            .store(in: &cancellables)
    }
}
