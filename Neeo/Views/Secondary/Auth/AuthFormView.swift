//
//  AuthFormView.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import SwiftUI

struct AuthFormView: View {
    var isRegister: Bool?
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Credentials")) {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
            } //: SECTION
            
            if self.isRegister == true {
                Button("Register") {  }
            } else {
                Button("Login") {  }
            }
        } //: NAVIGATION_VIEW
    }
}

struct AuthFormView_Previews: PreviewProvider {
    static var previews: some View {
        AuthFormView()
    }
}
