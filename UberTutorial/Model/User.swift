//
//  User.swift
//  UberTutorial
//
//  Created by minmin on 2021/10/08.
//

import Foundation
import CoreLocation

struct User {
    let fullname: String
    let email: String
    let accountType: Int
    var location: CLLocation?
    let uid: String

    init(uid: String,dictonary: [String: Any]) {
        self.uid = uid
        self.fullname = dictonary["fullname"] as? String ?? ""
        self.email = dictonary["email"] as? String ?? ""
        self.accountType = dictonary["accoutType"] as? Int ?? 0

    }
}
