//
//  AuthFormView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI
import PureSwiftUI
import Firebase

struct AuthFormView: View {
    // MARK: - State
    var isRegister: Bool?
    @EnvironmentObject var authSessionService: AuthService
    
    // MARK: - State (Initialiser-modifiable)
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    // MARK: - UI Components
    var body: some View {
        Form {
            if isError {
                Section(header: Text("Feedback")) {
                    Text(self.errorMessage)
                        .foregroundColor(.red)
                }
            }
            
            Section(header: Text("Credentials")) {
                TextField("Email", text: self.$email)
                SecureField("Password", text: self.$password)
            } //: SECTION
            
            
            if self.isRegister == true {
                Button("Register", action: self.register)
            } else {
                Button("Login", action: self.login)
            }
        } //: FORM
        .listStyle(GroupedListStyle())
    }
    
    // MARK: - Action Handlers
    private func login() {
        self.isLoading = true
        self.isError = false
        self.authSessionService.login(email: self.email, password: self.password, handler: self.handleResponse)
    }
    
    private func register() {
        self.isLoading = true
        self.isError = false
        self.authSessionService.register(email: self.email, password: self.password, handler: self.handleResponse)
    }
    
    private func handleResponse(result: AuthDataResult?, error: Error?) {
        self.isLoading = false
        if error != nil {
            self.isError = true
            if let error = error?.localizedDescription {
                self.errorMessage = error
            }
        } else {
            self.email = ""
            self.password = ""
        }
    }
}

struct AuthFormView_Previews: PreviewProvider {
    static var previews: some View {
        AuthFormView()
    }
}
