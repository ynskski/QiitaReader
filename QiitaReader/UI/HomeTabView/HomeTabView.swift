//
//  HomeTabView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/23.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView {
            ArticleListView()
                .tabItem {
                    Image(systemName: "doc.text")
                    Text("記事")
                }
        }
    }
}
