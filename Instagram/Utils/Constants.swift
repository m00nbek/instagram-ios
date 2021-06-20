//
//  Constants.swift
//  Instagram
//
//  Created by Oybek on 5/3/21.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_POSTS = DB_REF.child("posts")

// MARK: - Cells
let postCellIdentifier = "postCellIdentifier"
