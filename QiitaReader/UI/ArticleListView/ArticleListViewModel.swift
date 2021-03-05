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
    var currentPageNum = 0
    var searchText: String = "" {
        didSet {
            currentPageNum = 0
            articles = []
        }
    }

    private var cancellables: Set<AnyCancellable> = []

    func loadArticles() {
        currentPageNum += 1
        
        if searchText.isEmpty {
            loadNewArticles()
        } else {
            searchArticles(query: searchText)
        }
    }
    
    func loadNewArticles() {
        isLoading = true

        qiitaApiClient
            .fetchArticle(page: currentPageNum)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                }

                self.isLoading = false
            }, receiveValue: { articles in
                self.articles += articles
            })
            .store(in: &cancellables)
    }

    func searchArticles(query: String) {
        isLoading = true

        qiitaApiClient
            .fetchArticle(page: currentPageNum, query: query)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                }

                self.isLoading = false
            }, receiveValue: { articles in
                self.articles += articles
            })
            .store(in: &cancellables)
    }
}
