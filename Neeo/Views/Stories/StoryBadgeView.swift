//
//  StoryBadge.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct StoryBadgeView: View {
    // MARK: - State
    
    // MARK: - UI Components
    var body: some View {
        let IMAGE_SIZE: CGFloat = 55
        return HStack(spacing: 15) {
            Button(action: {}) {
                Image("avatar").resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: IMAGE_SIZE, height: IMAGE_SIZE)
                    .clipShape(Circle())
                    .overlay(
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                            .background(Color.white.clipShape(Circle()))
                            .offset(x: 8, y: 5), alignment: .bottomTrailing
                    )
                    .padding()
            } //: BUTTON
        } //: HSTACK
        .neumorphicShadow()
    }
}

struct StoryBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        StoryBadgeView()
    }
}
