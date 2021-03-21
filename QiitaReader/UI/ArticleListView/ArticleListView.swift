//
//  ArticleListView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import SwiftUI

struct ArticleListView: View {
    @ObservedObject var viewModel = ArticleListViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Search", text: self.$searchText, onCommit: {
                            viewModel.searchText = searchText

                            viewModel.loadArticles()
                        })
                            .keyboardType(.webSearch)
                    }

                    Section {
                        ForEach(viewModel.articles) { article in
                            ArticleRowView(article: article)
                                .onAppear {
                                    if article.id == viewModel.articles.last!.id {
                                        viewModel.loadArticles()
                                    }
                                }
                        }
                    }
                }
            }
            .onAppear {
                if viewModel.articles.isEmpty {
                    viewModel.loadArticles()
                }
            }
            .overlay(viewModel.isLoading ? AnyView(LoadingView()) : AnyView(EmptyView()))
            .navigationTitle("Articles")
        }
    }
}
