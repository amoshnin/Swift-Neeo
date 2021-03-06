//
//  TabBarButton.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct TabBarButtonView: View {
    // MARK: - State
    @Environment(\.colorScheme) var scheme
    
    // MARK: - State (Initialiser-modifiable)
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    
    var body: some View {
        let title = "\(image)\(selectedTab == image ? ".fill" : "")"
        return GeometryReader { geo -> AnyView in
            let midX = geo.frame(in: .global).midX
            
            DispatchQueue.main.async {
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
                Button(action: self.onTabClicked) {
                    Image(systemName: title)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(Color.primary)
                        .offset(y: self.selectedTab == self.image ? -8 : 0)
                } //: BUTTON
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        } //: GEOMETRY_READER
        .frame(height: 30)
    }
    
    private func onTabClicked() -> Void {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5))
            { self.selectedTab = self.image }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    
    static var previews: some View {
        let number: CGFloat = 23
        return TabBarButtonView(image: "house", selectedTab: .constant(""), tabPoints: .constant([number]))
    }
}
