//
//  NeeoApp.swift
//  Neeo
//
//  Created by Артём Мошнин on 5/3/21.
//

import SwiftUI

@main
struct NeeoApp: App {
    @AppStorage("isAuth") private var isAuth: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isAuth {
                ContentView()
            } else {
                ContentView()
            }
        }
    }
}
