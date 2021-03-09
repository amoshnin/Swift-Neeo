//
//  AuthHomeView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct AuthScreen: View {
    // MARK: - State
    @EnvironmentObject var authSessionService: AuthService
    
    // MARK: - UI Components
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Login with email", destination: AuthFormScreen())
                NavigationLink("Register with email", destination: AuthFormScreen(isRegister: true))
                
                Button("SignInWithGoogle") { authSessionService.signInWithGoogle() }
            } //: VSTACK
        } //: NAVIGATION_VIEW
    }
}

struct AuthHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AuthScreen()
    }
}
