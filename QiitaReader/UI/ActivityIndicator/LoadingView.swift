//
//  LoadingView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ActivityIndicatorView(isLoading: .constant(true), style: .medium)
        }
    }
}
