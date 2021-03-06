//
//  TabbarNavigator.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import SwiftUI
import PureSwiftUI

//private let 

private let tabs = ["house", "bookmark", "message", "person"]
struct TabBarNavigator: View {
    @State private var selectedTab = "house"
    @State private var tabPoints = [CGFloat]()
    
    var body: some View {
        //        TabView(selection: self.$selectedTab) {
        //            Text("Home")
        //                .tag("house.fill")
        ////            HomeView()
        ////                .tabItem { Label("Home", systemImage: "house") }
        ////
        ////            CalendarView()
        ////                .tabItem { Label("Calendar", systemImage: "house") }
        ////
        ////            MessangerView()
        ////                .tabItem { Label("Messanger", systemImage: "house") }
        ////
        ////            ProfileView()
        ////                .tabItem { Label("Profile", systemImage: "house") }
        //        } //: TAB_VIEW
        
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
        GeometryReader { geo -> AnyView in
            let midX = geo.frame(in: .global).midX
            
            DispatchQueue.main.async {
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            
            return AnyView(
                Button(action: { withAnimation { self.selectedTab = self.image } }) {
                    Image(systemName: "\(self.image)\(self.selectedTab == self.image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color("Primary"))
                        .offset(y: self.selectedTab == self.image ? -10 : 0)
                } //: BUTTON
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        } //: GEOMETRY_READER
        .frame(height: 50)
    }
}

private struct TabCurve: Shape {
    var tabPoint: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        
        
        return path
    }
}

struct TabBarNavigator_Previews: PreviewProvider {
    static var previews: some View {
        TabBarNavigator()
    }
}
