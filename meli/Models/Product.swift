//
//  Product.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

struct Product: Identifiable, Codable {
    let id: String
    let title: String
    let price: Double
    let category_id: String?
    let thumbnail: String
    let permalink: String
    let attributes: [Attribute]?
    
    struct Attribute: Codable, Identifiable {
        let id: String
        let name: String
        let value_name: String?
   }
}
