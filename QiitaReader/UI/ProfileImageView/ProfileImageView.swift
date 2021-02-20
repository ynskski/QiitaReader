//
//  ProfileImageView.swift
//  QiitaReader
//
//  Created by YunosukeSakai on 2021/01/22.
//

import SwiftUI

struct ProfileImageView: View {
    @ObservedObject var viewModel: ProfileImageViewModel

    init(imageURL: String) {
        viewModel = ProfileImageViewModel(imageURL: imageURL)
    }

    var body: some View {
        Image(uiImage: viewModel.image!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
    }
}
