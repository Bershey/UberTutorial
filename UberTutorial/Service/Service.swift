//
//  Service.swift
//  UberTutorial
//
//  Created by minmin on 2021/10/07.
//

import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

struct Service {

    static let shared = Service()

    func fetchUserData(completion: @escaping(String) -> Void) {
        let currentUid = Auth.auth().currentUser?.uid

        REF_USERS.child(currentUid!).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let fullname = dictionary["fullname"] as? String else { return }
            completion(fullname)
        }
    }
}
