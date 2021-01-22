//
//  ArticleRowView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/22.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("@\(article.user.id)")
                    .font(.caption)
                
                Text(article.createdAt)
                    .font(.caption)
            }
            
            Text(article.title)
                .font(.headline)
            
            Text("LGTM: \(article.likesCount)")
                .font(.caption)
        }.padding(4)
    }
}
