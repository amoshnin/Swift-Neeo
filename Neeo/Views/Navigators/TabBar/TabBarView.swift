//
//  TabbarNavigator.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import SwiftUI

// MARK: - Constants
private let tabs = ["newspaper", "clock", "tv", "person"]
struct TabBarNavigator: View {
    // MARK: - State
    @State private var selectedTab = tabs[0]
    @State private var tabPoints = [CGFloat]()
    @Environment(\.colorScheme) var scheme
    
    // MARK: - UI Components
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeScreen()
                .tag(tabs[0])
            CalendarScreen()
                .tag(tabs[1])
            MessangerScreen()
                .tag(tabs[2])
            ProfileScreen()
                .tag(tabs[3])
        }
        .overlay(customTabBar())
    }
    
    private func customTabBar() -> some View {
        VStack {
            Color.clear
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { item in
                    TabBarButtonView(image: item, selectedTab: self.$selectedTab, tabPoints: $tabPoints)
                }
            }
            .padding()
            .background((self.scheme == .dark ? Color("background3") : Color.white)  .clipShape(TabBarCurveShape(tabPoint: self.getCurvePoint() - 15)))
            .overlay(self.getCurveView(), alignment: .bottomLeading)
            .cornerRadius(15)
            .padding(.horizontal)
            .shadow(2)
            .neumorphicShadow()
        }
    }
    
    private func getCurveView() -> some View {
        Circle()
            .fill(Color.white)
            .frame(width: 5, height: 5)
            .offset(x: self.getCurvePoint() - 19.1)
            .shadow(1)
    }
    
    private func getCurvePoint() -> CGFloat {
        if tabPoints.isEmpty {
            return 10
        } else {
            switch selectedTab {
            case tabs[0]:
                return tabPoints[3]
            case tabs[1]:
                return tabPoints[2]
            case tabs[2]:
                return tabPoints[1]
            default:
                return tabPoints[0]
            }
        }
    }
}

struct TabBarNavigator_Previews: PreviewProvider {
    static var previews: some View {
        TabBarNavigator()
            .showLayoutGuides(true)
            .environmentObject(AuthService())
    }
}
