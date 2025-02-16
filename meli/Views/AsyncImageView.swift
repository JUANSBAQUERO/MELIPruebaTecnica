//
//  AsyncImageView.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

struct AsyncImageView: View {
    let imageUrl: String
    let height: CGFloat

    var body: some View {
        AsyncImage(url: URL(string: imageUrl.replacingOccurrences(of: "http://", with: "https://"))) { phase in
            switch phase {
            case .empty:
                LoadingView()
            case .success(let image):
                image.resizable()
                    .scaledToFit()
                    .frame(height: height)
                    .cornerRadius(8)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}
