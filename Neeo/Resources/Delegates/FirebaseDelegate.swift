//
//  FirebaseDelegate.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import Foundation
import Firebase

// MARK: - Connecting Firebase
class FirebaseDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
