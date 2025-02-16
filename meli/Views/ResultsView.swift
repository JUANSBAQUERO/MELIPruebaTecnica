//
//  ResultsView.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

struct ResultsView: View {
    let products: [Product]
    let isLandScape: Bool

    init(products: [Product], isLandScape: Bool = false) {
        self.products = products
        self.isLandScape = isLandScape
    }
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(products) { product in
                    Group {
                        if isLandScape {
                            ProductCardLandScapeView(product: product)
                        } else {
                            ProductCardView(product: product)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

