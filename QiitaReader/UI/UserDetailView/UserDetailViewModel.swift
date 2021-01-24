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
    
    private let qiitaApiClient = QiitaAPIClient.shared
    
    private var cancellables: Set<AnyCancellable> = []
    
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
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                self.isLoading = false
            }, receiveValue: { accessTokenResponse in
                UserAuthenticator.accessToken = accessTokenResponse.token
            })
            .store(in: &cancellables)
    }
}
