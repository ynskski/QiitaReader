//
//  ActivityIndicatorView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/21.
//

import SwiftUI
import UIKit

struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var isLoading: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context _: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context _: UIViewRepresentableContext<ActivityIndicatorView>) {
        if isLoading {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
