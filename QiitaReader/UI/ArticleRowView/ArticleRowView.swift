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
                
                Text("が\(ymdFormattedDate(article.createdAt))に投稿")
                    .font(.caption)
            }
            
            Text(article.title)
                .font(.headline)
            
            Text("LGTM: \(article.likesCount)")
                .font(.caption)
        }.padding(4)
    }
    
    func ymdFormattedDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        guard let date = dateFormatter.date(from: date) else {
            return ""
        }
        
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: date)
        guard let year = dateComponents.year,
              let month = dateComponents.month,
              let day = dateComponents.day else {
            return ""
        }
        
        return "\(year)年\(month)月\(day)日"
    }
}
