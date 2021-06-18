//
//  User.swift
//  Instagram
//
//  Created by Oybek on 6/12/21.
//

import Firebase
struct User {
    let email: String
    let username: String
    let fullname: String
    var profileImageUrl: URL?
    let uid: String
    var isCurrentUser: Bool {return Auth.auth().currentUser?.uid == uid}

    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else {return}
            self.profileImageUrl = url
        }
        
    }
}
