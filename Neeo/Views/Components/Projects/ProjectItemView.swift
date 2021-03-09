//
//  ProjectItemView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct ProjectItemView: View {
    // MARK: - State
    @State private var isShimmering = false
    
    // MARK: - State (Initialiser-modifiable)
    var project: Project
    
    // MARK: - UI Components
    var body: some View {
        let isLoading = self.project.title != nil
        HStack {
            if (isLoading) { self.shimmerView() } else { self.viewView() }
        }
        .padding()
        .onAppear { self.startShimmering() }
    }
    
    // MARK: - UI Functions
    // Main View
    private func viewView() -> some View {
        Group {
            VStack(alignment: .leading) {
                Text(self.project.title)
                    .font(.title3)
                Text(self.project.description)
                    .font(.subheadline)
            } //: VSTACK
            Spacer()
        } //: GROUP
    }
    
    private let opacity1 = 0.09
    private let color1 = Color.black
    
    private let opacity2 = 0.6
    private let color2 = Color.white
    
    // Shimmer View
    private func shimmerView() -> some View {
        return ZStack {
            self.shimmerBlocksView(color: color1, opacity: opacity1)
            self.shimmerBlocksView(color: color2, opacity: opacity2)
            // Masking animation
                .mask(self.shimmerMask())
        } //: ZSTACK
    }
    
    private func shimmerBlocksView(color: Color, opacity: Double) -> some View {
        HStack(spacing: 15) {
            Circle()
                .fill(color.opacity(opacity))
                .frame(width: 75, height: 75)
            
            VStack(alignment: .leading, spacing: 12) {
                Rectangle()
                    .fill(color.opacity(opacity))
                    .frame(width: 250, height: 15)
                
                Rectangle()
                    .fill(color.opacity(opacity))
                    .frame(width: 100, height: 15)
            } //: VSTACK
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        } //: HSTACK
    }
    
    private func shimmerMask() -> some View {
        Rectangle()
            .fill(color2.opacity(opacity2))
            .rotationEffect(.init(degrees: 70))
            .offset(x: self.isShimmering ? 1000 : -350)
    }
    
    // MARK: - Action Functions
    private func startShimmering() -> Void {
        withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
            self.isShimmering.toggle()
        }
    }
}

struct ProjectItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectItemView(project: Project(title: "Some title", description: "Some description"))
    }
}
