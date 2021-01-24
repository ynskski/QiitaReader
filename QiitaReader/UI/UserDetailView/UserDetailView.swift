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
                if let token = UserAuthenticator.accessToken {
                    Text(token)
                } else {
                    requireLoginView
                }
            }
            .overlay(viewModel.isLoading ? AnyView(LoadingView()) : AnyView(EmptyView()))
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
            .disabled(viewModel.isLoading)
            .sheet(isPresented: $isPresentedOauthPage) {
                WebView(url: QiitaAPIClient.oauthUrlString!, isPresented: $isPresentedOauthPage)
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
