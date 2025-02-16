//
//  ProductCardLandScape.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

struct ProductCardLandScapeView: View {
    let product: Product

    var body: some View {
        NavigationLink(destination: ProductDetailView(product: product)) {
            HStack(alignment: .center, spacing: 0) {
                AsyncImageView(imageUrl: product.thumbnail, height: 120)
                
                DividerView(size: 150, isHorizontal: false)
                    .padding(.horizontal, 10)
                
                VStack {
                    Spacer()
                    
                    Text(product.title)
                        .subtitleStyle()
                    
                    Spacer()
                    
                    Text(product.price.isNaN ? "Precio no disponible" : product.price.formattedPrice())
                        .subtitleStyle(font: .subheadline)
                        .padding(.horizontal)
                }
            }
            .containerStyle(minWidth: 300, maxWidth: 300, minHeight: 130, maxHeight: 130)
        }
    }
}
