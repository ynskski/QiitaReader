//
//  ArticleListView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import SwiftUI

struct ArticleListView: View {
    @ObservedObject var viewModel = ArticleListViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(viewModel.articles) { article in
                        Text(article.title)
                    }
                }
            }
            .navigationTitle("Articles")
        }
    }
}
