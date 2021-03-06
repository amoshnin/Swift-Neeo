//
//  NeeoApp.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import SwiftUI
import Firebase

@main
struct NeeoApp: App {
    @AppStorage("isAuth") private var isAuth: Bool = false
    @UIApplicationDelegateAdaptor(FirebaseDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            if isAuth {
                TabBarNavigator()
            } else {
                WelcomeView()
            }
        }
    }
}
