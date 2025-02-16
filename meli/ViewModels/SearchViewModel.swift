//
//  SearchViewModel.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results: [Product] = []
    @Published var isLoading = false

    private let service: MeliServiceProtocol

    init(service: MeliServiceProtocol = MeliService()) {
        self.service = service
    }

    func searchProducts() {
        isLoading = true
        service.searchProducts(query: searchText) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let searchResult):
                    self?.results = searchResult.results
                case .failure:
                    self?.results = []
                }
            }
        }
    }
}
