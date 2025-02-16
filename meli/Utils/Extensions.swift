//
//  Extensions.swift
//  meli
//
//  Created by Juan  on 15/02/25.
//

import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Constants.mainColor
                .edgesIgnoringSafeArea(.all)
            content
        }
    }
}

extension View {
    func buttonPrimary() -> some View {
        self.padding()
            .background(Color(Constants.meliBlue))
            .cornerRadius(10)
            .foregroundColor(Color.white)
    }
    
    func titleStyle() -> some View {
        self.font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .padding(.bottom, 5)
    }
    
    func subtitleStyle(color: Color = Constants.meliBlue, font: Font = .caption) -> some View {
        self.font(font)
            .fontWeight(.semibold)
            .foregroundColor(color)
            .padding(.bottom, 5)
    }
    
    func textFieldStyle() -> some View {
        self.padding()
            .frame(height: 50)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
    }
    
    func iconNoProductStyle () -> some View {
        self.scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(Constants.meliBlue)
            .padding()
    }
    
    func appBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
    
    func containerStyle(minWidth: Double = 140, maxWidth: Double = 140, minHeight: Double = 200, maxHeight: Double = 260) -> some View {
        self.frame(minWidth: minWidth, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight)
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 3)
    }
}

extension Double {
    func formattedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "es_CO")
        formatter.currencySymbol = "$"

        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return formattedString.replacingOccurrences(of: "\u{00A0}", with: " ")
        } else {
            return "$\(self)"
        }
    }
}

