//
//  AuthenticationService.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI
import Combine
import Firebase
import GoogleSignIn

class AuthSessionService: ObservableObject {
    var didChange = PassthroughSubject<AuthSessionService, Never>()
    @Published var session: UserModel? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = UserModel(uid: user.uid, email: user.email, displayName: user.displayName, photoURL: user.photoURL)
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signInWithGoogle() {
        GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance().signIn()
    }
    
    func register(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func login(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func logout () {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {}
    }
}

