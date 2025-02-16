//
//  LoadingView.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

struct LoadingView: View {
    var text: String = "Cargando..."

    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Constants.meliBlue))
                .scaleEffect(1.5)

            Text(text)
                .font(.headline)
                .foregroundColor(Constants.meliBlue)
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.8))
    }
}
