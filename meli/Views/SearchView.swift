//
//  SearchView.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @State private var showLogo = true
    @StateObject private var orientationManager = OrientationManager()

    var body: some View {
        NavigationView {
            VStack {
                if showLogo {
                    Image("logomeli")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 100)
                        .transition(.opacity)
                }

                Text("¿Qué quieres buscar hoy?")
                    .titleStyle()
                    .padding(.top, showLogo ? 0 : 30)

                HStack(alignment: .top, spacing: 0) {
                    TextField("Buscar productos...", text: $viewModel.searchText)
                        .textFieldStyle()
                        .frame(
                            width: orientationManager.isLandscape ? 580 : 280,
                            height: 50
                        )
                        .frame(maxWidth: .infinity)

                    Button(action: {
                        withAnimation(.easeInOut(duration: 1)) {
                            viewModel.searchProducts()
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                    .buttonPrimary()
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 10, leading: orientationManager.isLandscape ? 30 : 0, bottom: 0, trailing:  orientationManager.isLandscape ? 30 : 20))

                HStack {
                    DividerView(size: orientationManager.isLandscape ? 250 : 150)

                    Image(systemName: "shippingbox.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.horizontal, 10)
                        .foregroundColor(Constants.meliBlue)

                    DividerView(size: orientationManager.isLandscape ? 250 : 150)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)

                if viewModel.isLoading {
                    LoadingView()
                } else if viewModel.results.isEmpty {
                    VStack {
                        Image(systemName: "magnifyingglass.circle")
                            .resizable()
                            .iconNoProductStyle()

                        Text("No se encontraron resultados")
                            .font(.headline)
                            .foregroundColor(Constants.meliBlue)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxHeight: .infinity)
                    .transition(.opacity)
                } else {
                    ResultsView(products: viewModel.results, isLandScape: orientationManager.isLandscape)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 1), value: showLogo)
            .onChange(of: viewModel.results.count) {
                withAnimation(.easeInOut(duration: 1)) {
                    showLogo = viewModel.results.isEmpty
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .appBackground()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                orientationManager.updateOrientation()
            }
        }
    }
}
