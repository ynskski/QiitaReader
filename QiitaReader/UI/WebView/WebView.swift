//
//  WebView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    @Binding var isPresented: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let wkWebView = WKWebView()
        wkWebView.navigationDelegate = context.coordinator
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: url) else {
            return
        }
        uiView.load(URLRequest(url: url))
    }
    
    func makeCoordinator() -> WebView.Coordinator {
        return Coordinator(parent: self)
    }
}

extension WebView {
    final class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView
        
        init(parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.request.url?.scheme == "qiita-reader" {
                if let url = navigationAction.request.url, let code = getQueryCode(url) {
                    UserAuthenticator.authenticationCode = code
                    parent.isPresented.toggle()
                }
            }

            decisionHandler(WKNavigationActionPolicy.allow)
        }
        
        private func getQueryCode(_ url: URL) -> String? {
            guard url.lastPathComponent == "QiitaReader" else {
                return nil
            }
            
            guard let urlComponents = URLComponents(string: url.absoluteString),
                  let queryItems = urlComponents.queryItems,
                  queryItems.count == 1 else {
                return nil
            }
            
            guard let code = queryItems.first(where: { $0.name == "code" })?.value else {
                return nil
            }
            
            return code
        }
    }
}
