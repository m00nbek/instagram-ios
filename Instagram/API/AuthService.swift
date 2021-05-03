//
//  AuthService.swift
//  Instagram
//
//  Created by Oybek on 5/3/21.
//

import Foundation
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let username: String
    let fullname: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { authResult, error in
            guard let uid = authResult?.user.uid else {return}
            let ref = Database.database().reference().child("users").child(uid)
            //ref.updateChildValues(, withCompletionBlock: completion)
        }
    }
    
}
