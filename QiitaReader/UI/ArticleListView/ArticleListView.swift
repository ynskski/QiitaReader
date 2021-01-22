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
                            viewModel.articles = []
                            
                            if searchText.isEmpty {
                                viewModel.loadArticles(page: 1)
                            } else {
                                viewModel.loadArticles(page: 1, query: searchText)
                            }
                        })
                            .keyboardType(.webSearch)
                    }
                    
                    Section {
                        ForEach(viewModel.articles) { article in
                            ArticleRowView(article: article)
                        }
                    }
                }
            }
            .overlay(viewModel.isLoading ? AnyView(loadingView) : AnyView(EmptyView()))
            .navigationTitle("Articles")
        }
    }
    
    var loadingView: some View {
        VStack {
            ActivityIndicatorView(isLoading: .constant(true), style: .medium)
        }
    }
}
