//
//  ProfileView.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import SwiftUI

struct ProfileScreen: View {
    // MARK: - State
    @EnvironmentObject var authService: AuthService
    
    // MARK: - UI Components
    var body: some View {
        NavigationView {
            VStack {
                Text("Account: \(authService.user?.email ?? "")")
                Button("Logout", action: self.authService.logout)
            } //: VSTACK
            .navigationBarTitle("Profile")
        } //: NAVIGATION_VIEW
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
            .environmentObject(AuthService())
    }
}
