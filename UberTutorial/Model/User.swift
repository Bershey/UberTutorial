//
//  User.swift
//  UberTutorial
//
//  Created by minmin on 2021/10/08.
//

import Foundation

struct User {
    let fullname: String
    let email: String
    let accountType: Int

    init(dictonary: [String: Any]) {
        self.fullname = dictonary["fullname"] as? String ?? ""
        self.email = dictonary["email"] as? String ?? ""
        self.accountType = dictonary["accoutType"] as? Int ?? 0

    }
}
