//
//  OnboardingView.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("isAuth") private var isAuth: Bool = false
    
    var body: some View {
        VStack {
            Button("Login") { self.isAuth = true }
        } //: VSTACK
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
