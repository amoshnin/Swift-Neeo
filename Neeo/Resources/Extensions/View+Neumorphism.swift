//
//  View+Neumorphism.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

let darkenWhite = #colorLiteral(red: 0.9305374026, green: 0.9509723783, blue: 0.9908421636, alpha: 1)
let purplish = #colorLiteral(red: 0.3607843137, green: 0.4941176471, blue: 0.9764705882, alpha: 1)

extension View {
    func neumorphicShadow() -> some View {
        self.modifier(NuemorphicShadow())
    }
}


private struct NuemorphicShadow: ViewModifier {
    func body(content: Content) -> some View {
            content
                .shadow(color: Color(purplish).opacity(0.6), radius: 5, x: 5, y: 5)
                .shadow(color: Color.white, radius: 5, x: -5, y: -5)
    }
}

