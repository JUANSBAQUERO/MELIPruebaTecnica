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
    let thumbnail: String
}