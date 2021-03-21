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
            UserDetailView()
                .tabItem {
                    Image(systemName: "person")
                    Text("ユーザー")
                }

            ArticleListView()
                .tabItem {
                    Image(systemName: "doc.text")
                    Text("記事")
                }
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
