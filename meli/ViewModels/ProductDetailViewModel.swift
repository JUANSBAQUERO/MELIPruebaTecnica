//
//  ProductDetailViewModel.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

class ProductDetailViewModel: ObservableObject {
    @Published var product: Product

    init(product: Product) {
        self.product = product
    }
}
