//
//  ProductCardView.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

struct ProductCardView: View {
    let product: Product

    var body: some View {
        NavigationLink(destination: ProductDetailView(product: product)) {
            VStack {
                AsyncImageView(imageUrl: product.thumbnail, height: 120)
                
                DividerView()
                
                Text(product.title)
                    .subtitleStyle()
                
                Spacer()
                
                Text(product.price.isNaN ? "Precio no disponible" : product.price.formattedPrice())
                    .subtitleStyle(font: .subheadline)
                    .padding(.horizontal)
            }
            .containerStyle()        }
    }
}
