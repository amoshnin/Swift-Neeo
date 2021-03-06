//
//  AuthHomeView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authSessionService: AuthService
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Login with email", destination: AuthFormView())
                NavigationLink("Register with email", destination: AuthFormView(isRegister: true))
                
                Button("SignInWithGoogle") { authSessionService.signInWithGoogle() }
            } //: VSTACK
        } //: NAVIGATION_VIEW
    }
}

struct AuthHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
