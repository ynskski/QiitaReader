//
//  UserDetailView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/23.
//

import SwiftUI

struct UserDetailView: View {
    @ObservedObject var viewModel = UserDetailViewModel()

    @State private var isPresentedOauthPage = false
    @State private var isPresentedAlert = false

    var body: some View {
        NavigationView {
            VStack {
                if let user = UserAuthenticator.authenticatedUser {
                    userInfoView(user)
                } else {
                    requireLoginView
                }
            }
            .overlay(viewModel.isLoading ? AnyView(LoadingView()) : AnyView(EmptyView()))
            .navigationTitle("User")
        }
    }

    func userInfoView(_ user: AuthenticatedUser) -> some View {
        Form {
            Section {
                HStack {
                    Spacer()

                    VStack(alignment: .center) {
                        ProfileImageView(imageURL: user.profileImageURL)
                            .frame(width: 60, height: 60)

                        Text("@\(user.id)")
                            .font(.callout)

                        HStack {
                            if let githubId = user.githubId {
                                socialIconView("github", id: githubId)
                            }

                            if let twitterId = user.twitterId {
                                socialIconView("twitter", id: twitterId)
                            }
                        }

                        Text(user.description)

                        HStack {
                            VStack(alignment: .center) {
                                Text("\(user.itemsCount)")
                                    .font(.body)
                                Text("　投稿数　")
                                    .font(.caption)
                            }

                            VStack(alignment: .center) {
                                Text("\(user.followeesCount)")
                                    .font(.body)
                                Text("　フォロー　")
                                    .font(.caption)
                            }

                            VStack(alignment: .center) {
                                Text("\(user.followersCount)")
                                    .font(.body)
                                Text("フォロワー")
                                    .font(.caption)
                            }
                        }
                        .padding(.top)
                    }
                    .padding(4)

                    Spacer()
                }
            }

            Section(header: Text("my articles")) {
                ForEach(viewModel.articles) { article in
                    ArticleRowView(article: article)
                }
            }
        }
        .onAppear {
            if viewModel.articles.isEmpty {
                viewModel.loadArticles()
            }
        }
    }

    func socialIconView(_ service: String, id _: String) -> some View {
        VStack(alignment: .center) {
            Image(service)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
        }
    }

    var requireLoginView: some View {
        VStack {
            Button {
                isPresentedOauthPage.toggle()
            } label: {
                Text("ログイン")
                    .font(.headline)
                    .padding()
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(Color.white)
            .background(Color.green)
            .disabled(viewModel.isLoading)
            .sheet(isPresented: $isPresentedOauthPage) {
                WebView(url: QiitaAPIClient.oauthUrlString, isPresented: $isPresentedOauthPage)
                    .onDisappear {
                        viewModel.login()
                    }
            }
            .alert(isPresented: $isPresentedAlert) {
                Alert(title: Text("No client_id"), message: nil, dismissButton: .cancel())
            }
        }
    }
}
