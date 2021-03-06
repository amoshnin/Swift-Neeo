//
//  ProfileView.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authSessionService: AuthSessionService
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Logout", action: self.authSessionService.logout)
            } //: VSTACK
            .navigationBarTitle("Profile")
        } //: NAVIGATION_VIEW
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
