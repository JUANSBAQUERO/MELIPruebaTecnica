//
//  ProductDetailView.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageView(imageUrl: product.thumbnail, height: 120)

                VStack(alignment: .leading, spacing: 8) {
                    Text(product.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    Text(product.price.isNaN ? "Precio no disponible" : product.price.formattedPrice())
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                        .padding(.horizontal)

                }

                Spacer()
            }
        }
        .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
    }
}
