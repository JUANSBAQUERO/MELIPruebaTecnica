//
//  ProductDetailView.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @StateObject var viewModel: ProductDetailViewModel
    @StateObject private var orientationManager = OrientationManager()
       
    init(product: Product) {
        self.product = product
        _viewModel = StateObject(wrappedValue: ProductDetailViewModel(product: product))
    }
    
    @State private var isVisible = false

    var body: some View {
        ScrollView {
            VStack(alignment: orientationManager.isLandscape ? .center : .leading, spacing: 16) {
                
                VStack {
                    Text(product.title)
                        .titleStyle()
                        .padding(.horizontal)
                }
                .fadeInUp(isVisible: isVisible, delay: 0.2)
                .containerDetailStyle( maxWidth: .infinity)
                .padding(.horizontal)
                
                HStack(alignment: .top) {
                    VStack {
                        VStack {
                            AsyncImageView(imageUrl: product.thumbnail, height: 120)
                        }
                        .fadeInUp(isVisible: isVisible)
                        .containerDetailStyle(minWidth: orientationManager.isLandscape ? 220 : 140, maxWidth: orientationManager.isLandscape ? 220 : 140)
                        
                        Spacer()
                        
                        VStack {
                            Text(product.price.isNaN ? "Precio no disponible" : product.price.formattedPrice() + " COP")
                                .subtitleStyle(font: .subheadline)

                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .fadeInUp(isVisible: isVisible, delay: 0.2)
                        .containerDetailStyle(minWidth: orientationManager.isLandscape ? 220 : 140, maxWidth: orientationManager.isLandscape ? 220 : 140)
                        
                        if(!orientationManager.isLandscape){
                            Spacer()
                            
                            VStack {
                                Button(action: {
                                    if let url = URL(string: product.permalink) {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    HStack {
                                        Text("Ver más")
                                            .font(.body)
                                        Image(systemName: "chevron.right")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .buttonPrimary()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .fadeInUp(isVisible: isVisible, delay: 0.2)
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        VStack {
                            if let attributes = product.attributes {
                                let columns = orientationManager.isLandscape ? [GridItem(.flexible()), GridItem(.flexible())] : [GridItem(.flexible())]
                                LazyVGrid(columns: columns, spacing: 12) {
                                    ForEach(attributes.prefix(4)) { attribute in
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(attribute.name)
                                                .font(.headline)
                                            Text(attribute.value_name ?? "No aplica")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .fadeInUp(isVisible: isVisible, delay: 0.6)
                                        .padding(.bottom)
                                    }
                                }
                            } else {
                                Text("Este producto no tiene especificaciones.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .fadeInUp(isVisible: isVisible, delay: 0.6)
                            }
                        }
                        .fadeInUp(isVisible: isVisible, delay: 0.4)
                        .containerDetailStyle(minWidth: orientationManager.isLandscape ? 400 : 160, maxWidth: orientationManager.isLandscape ? 400 : 160)
                        
                        if(orientationManager.isLandscape){
                            VStack {
                                Button(action: {
                                    if let url = URL(string: product.permalink) {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    HStack {
                                        Text("Ver más")
                                            .font(.body)
                                        Image(systemName: "chevron.right")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .buttonPrimary()
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .fadeInUp(isVisible: isVisible, delay: 0.2)
                        }
                    }
                }
                .padding(.horizontal)
                
                if viewModel.isLoading {
                    LoadingView()
                }else if !viewModel.recommendedProducts.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Productos recomendados")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.recommendedProducts) { recommendedProduct in
                                    ProductCardView(product: recommendedProduct)
                                        .fadeInUp(isVisible: isVisible, delay: 0.8)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .onAppear {
            isVisible = true
            viewModel.fetchRecommendedProducts()
        }
        .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
        .appBackground()
    }
}
