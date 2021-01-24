//
//  UserDetailView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/23.
//

import SwiftUI

struct UserDetailView: View {
    @State private var isPresentedOauthPage = false
    @State private var isPresentedAlert = false
    
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
                if QiitaAPIClient.oauthUrlString != nil {
                    isPresentedOauthPage.toggle()
                } else {
                    isPresentedAlert.toggle()
                }
            } label: {
                Text("ログイン")
                    .font(.headline)
                    .padding()
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(Color.white)
            .background(Color.green)
            .sheet(isPresented: $isPresentedOauthPage) {
                WebView(url: QiitaAPIClient.oauthUrlString!, isPresented: $isPresentedOauthPage)
            }
            .alert(isPresented: $isPresentedAlert) {
                Alert(title: Text("No client_id"), message: nil, dismissButton: .cancel())
            }
        }
    }
}
