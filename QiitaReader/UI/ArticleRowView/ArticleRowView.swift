//
//  ArticleRowView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/22.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article

    @State private var isPresentedSafariView = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ProfileImageView(imageURL: article.user.profileImageURL)
                    .frame(width: 20, height: 20)

                Text("@\(article.user.id)")
                    .font(.caption)

                Text("が\(ymdFormattedDate(article.createdAt))に投稿")
                    .font(.caption)
            }

            Text(article.title)
                .font(.headline)

            HStack {
                Image(systemName: "tag")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)

                ForEach(article.tags, id: \.self) { tag in
                    Text(tag.name)
                        .lineLimit(0)
                        .font(.caption)
                }
            }

            HStack {
                Image(systemName: "hand.thumbsup")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)

                Text("\(article.likesCount)")
                    .font(.caption)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isPresentedSafariView.toggle()
        }
        .sheet(isPresented: $isPresentedSafariView) {
            SafariView(url: URL(string: article.url)!).edgesIgnoringSafeArea(.bottom)
        }
        .padding(4)
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
              let day = dateComponents.day
        else {
            return ""
        }

        return "\(year)年\(month)月\(day)日"
    }
}
