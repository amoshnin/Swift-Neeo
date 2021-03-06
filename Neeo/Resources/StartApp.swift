//
//  NeeoApp.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import SwiftUI
import Firebase

@main
struct StartView: App {
    @UIApplicationDelegateAdaptor(FirebaseDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            VStack {
                AuthNavigatorView()
            }.environmentObject(AuthService())
        } //: WINDOW_GROUP
        
    }
}

private struct AuthNavigatorView: View {
    @AppStorage("isAuth") private var isAuth: Bool = false
    @EnvironmentObject var authSessionService: AuthService
    
    var body: some View  {
        VStack {
            if self.isAuth {
                if self.authSessionService.user != nil {
                    TabBarNavigator()
                } else {
                    AuthView()
                }
            } else {
                WelcomeView()
            }
        } //: VSTACK
        .onAppear { self.authSessionService.listen() }
    }
}
