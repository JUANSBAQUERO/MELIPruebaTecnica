//
//  ViewMoreButton.swift
//  meli
//
//  Created by Juan  on 16/02/25.
//

import SwiftUI

struct ViewMoreButton: View {
    let url: String
    let isVisible: Bool

    var body: some View {
        VStack {
            Button(action: {
                if let url = URL(string: url) {
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
