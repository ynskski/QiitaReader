//
//  UserDetailViewModel.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/24.
//

import Combine
import Foundation

final class UserDetailViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var articles: [Article] = []

    private let qiitaApiClient = QiitaAPIClient.shared

    private var cancellables: Set<AnyCancellable> = []

    var user: AuthenticatedUser? {
        UserAuthenticator.authenticatedUser
    }

    func login() {
        guard let code = UserAuthenticator.authenticationCode else {
            return
        }

        isLoading = true

        qiitaApiClient
            .fetchAccessToken(code: code)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                }

                self.isLoading = false
            }, receiveValue: { accessTokenResponse in
                UserAuthenticator.accessToken = accessTokenResponse.token
                self.loadUser()
            })
            .store(in: &cancellables)
    }

    func loadArticles() {
        isLoading = true

        qiitaApiClient
            .fetchAuthenticatedUserItems(page: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                }

                self.isLoading = false
            }, receiveValue: { articles in
                self.articles = articles
            })
            .store(in: &cancellables)
    }

    private func loadUser() {
        guard let token = UserAuthenticator.accessToken else {
            return
        }

        isLoading = true

        qiitaApiClient
            .fetchAuthenticatedUser(token: token)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                }

                self.isLoading = false
            }, receiveValue: { user in
                UserAuthenticator.authenticatedUser = user
            })
            .store(in: &cancellables)
    }
}
