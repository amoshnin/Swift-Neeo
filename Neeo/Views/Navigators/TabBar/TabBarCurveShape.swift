//
//  TabBarCurve.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct TabBarCurveShape: Shape {
    // MARK: - State
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
