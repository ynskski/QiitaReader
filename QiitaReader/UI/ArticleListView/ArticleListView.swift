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
            VStack {
                Form {
                    Section {
                        ForEach(viewModel.articles) { article in
                            Text(article.title)
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
