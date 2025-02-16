//
//  ProductDetailViewModel.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

class ProductDetailViewModel: ObservableObject {
    @Published var product: Product
    @Published var recommendedProducts: [Product] = []
    @Published var isLoading = false
    
    private let service: MeliServiceProtocol
    
    init(product: Product, service: MeliServiceProtocol = MeliService()) {
           self.product = product
           self.service = service
       }
    
    func fetchRecommendedProducts() {
        guard let categoryId = product.category_id else {
            print("No se encontró la categoría del producto")
            return
        }
        
        service.searchProductsByCategory(categoryId: categoryId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let searchResult):
                    self?.recommendedProducts = searchResult.results
                case .failure:
                    self?.recommendedProducts = []
                }
            }
        }
    }
}
