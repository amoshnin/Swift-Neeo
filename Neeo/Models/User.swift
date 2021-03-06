//
//  UserModel.swift
//  Neeo
//
//  Created by Артём Мошнин on 6/3/21.
//

import Foundation

struct User {
    var uid: String
    var email: String?
    var displayName: String?
    var photoURL: URL?

    init(uid: String, email: String?, displayName: String?, photoURL: URL?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.photoURL = photoURL
    }
}
