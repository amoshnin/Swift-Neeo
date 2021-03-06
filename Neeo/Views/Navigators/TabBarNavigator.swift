//
//  TabbarNavigator.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import SwiftUI

private let tabs = ["newspaper", "clock", "message", "person"]
struct TabBarNavigator: View {
    @State private var selectedTab = "house"
    @State private var tabPoints = [CGFloat]()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("Primary")
                .edgesIgnoringSafeArea(.all)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { item in
                    TabBarButton(image: item, selectedTab: self.$selectedTab, tabPoints: $tabPoints)
                }
            }
            .padding()
            .background(Color.white.clipShape(TabCurve(tabPoint: self.getCurvePoint() - 15)))
            .overlay(
            Circle()
                .fill(Color.white)
                .frame(width: 7, height: 7)
                .offset(x: self.getCurvePoint() - 19.1)
                , alignment: .bottomLeading
            )
            .cornerRadius(30)
            .padding(.horizontal)
        }
    }
    
    private func getCurvePoint() -> CGFloat {
        if tabPoints.isEmpty {
            return 10
        } else {
            switch selectedTab {
            case tabs[0]:
                return tabPoints[0]
            case tabs[1]:
                return tabPoints[1]
            case tabs[2]:
                return tabPoints[2]
            default:
                return tabPoints[3]
            }
        }
    }
}


struct TabBarButton: View {
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
                Button(action: { withAnimation(
                        .interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) { self.selectedTab = self.image } }) {
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
    
}

private struct TabCurve: Shape {
    var tabPoint: CGFloat
    
    // MARK: - Path animations
    var animatableData: CGFloat {
        get { return tabPoint }
        set { tabPoint = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // MARK: - Drawing outer lines
        path.move(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        
        // MARK: - Constants
        let mid = tabPoint
        
        let horizontalRadius: CGFloat = 40
        let topHorizontalRadius: CGFloat = 15
        let curvingRate: CGFloat = 14
        
        // MARK: - Drawing curves
        path.move(to: CGPoint(x: mid - horizontalRadius, y: rect.height))
        
        let to = CGPoint(x: mid, y: rect.height - curvingRate)
        let control1 = CGPoint(x: mid - topHorizontalRadius, y: rect.height)
        let control2 = CGPoint(x: mid - topHorizontalRadius, y: rect.height - curvingRate)
        
        let to1 = CGPoint(x: mid + horizontalRadius, y: rect.height)
        let control3 = CGPoint(x: mid + topHorizontalRadius, y: rect.height - curvingRate )
        let control4 = CGPoint(x: mid + topHorizontalRadius, y: rect.height)
        
        path.addCurve(to: to, control1: control1, control2: control2)
        path.addCurve(to: to1, control1: control3, control2: control4)
        
        return path
    }
}

struct TabBarNavigator_Previews: PreviewProvider {
    static var previews: some View {
        TabBarNavigator()
            .showLayoutGuides(true)
    }
}
