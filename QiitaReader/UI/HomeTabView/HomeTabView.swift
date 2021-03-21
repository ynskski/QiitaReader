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
                    Image(systemName: "person.fill")
                    Text("ユーザー")
                }

            ArticleListView()
                .tabItem {
                    Image(systemName: "doc.text.fill")
                    Text("記事")
                }
        }
        .accentColor(Color.primary)
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
