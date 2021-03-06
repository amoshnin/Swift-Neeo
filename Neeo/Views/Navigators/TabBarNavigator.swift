//
//  TabbarNavigator.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import SwiftUI

struct TabBarNavigator: View {
    var body: some View {
        TabView {
            HomeView(projectsListViewModel: ProjectsListViewModel())
                .tabItem { Label("Home", systemImage: "house") }
            
            CalendarView()
                .tabItem { Label("Calendar", systemImage: "house") }
            
            MessangerView()
                .tabItem { Label("Messanger", systemImage: "house") }
            
            ProfileView()
                .tabItem { Label("Profile", systemImage: "house") }
        }
    }
}

struct TabBarNavigator_Previews: PreviewProvider {
    static var previews: some View {
        TabBarNavigator()
    }
}
