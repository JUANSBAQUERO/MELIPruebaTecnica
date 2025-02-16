//
//  DividerView.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

struct DividerView: View {
    var size: CGFloat = 150
    var color: Color = Constants.meliBlue
    var isHorizontal: Bool = true

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(
                width: isHorizontal ? size : 1,
                height: isHorizontal ? 1 : size
            )
    }
}
