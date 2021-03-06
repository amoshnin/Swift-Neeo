//
//  FirebaseDelegate.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import Foundation
import Firebase
import GoogleSignIn

// MARK: - Connecting Firebase
class FirebaseDelegate: NSObject, UIApplicationDelegate, GIDSignInDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        // Intializing Google Sign In...
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    // MARK: - GoogleSignIn
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Signed in \(user.authentication.idToken)")
        if error != nil {
            print(error.localizedDescription)
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
        
        // Logging to Firebase...
        Auth.auth().signIn(with: credential) { (result, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            // User Logged In Succesfully
            
            // Printing Email
            print(result?.user.email)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform action when user logs out...
    }
}
