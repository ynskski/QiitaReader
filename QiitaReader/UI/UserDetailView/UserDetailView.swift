//
//  UserDetailView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/23.
//

import SwiftUI

struct UserDetailView: View {
    @State private var isPresentedOauthPage = false
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = UserAuthenticator.authenticatedUser {
                    Text(user.id)
                } else {
                    requireLoginView
                }
            }
            .navigationTitle("User")
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
            .sheet(isPresented: $isPresentedOauthPage) {
                WebView(url: UserAuthenticator.oauthUrlString)
            }
        }
    }
}
