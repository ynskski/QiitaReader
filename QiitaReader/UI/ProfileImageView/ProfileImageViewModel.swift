//
//  ProfileImageViewModel.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/22.
//

import Combine
import UIKit

final class ProfileImageViewModel: ObservableObject {
    @Published private(set) var image = UIImage(systemName: "photo")
    
    private let qiitaApiClient = QiitaAPIClient.shared
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(imageURL: String) {
        loadProfileImage(from: imageURL)
    }
    
    func loadProfileImage(from imageURL: String) {
        guard let url = URL(string: imageURL) else {
            return
        }
        
        qiitaApiClient
            .fetchProfileImage(url: url)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { uiImage in
                self.image = uiImage
            })
            .store(in: &cancellables)
    }
}
