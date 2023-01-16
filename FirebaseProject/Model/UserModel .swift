//
//  UserModel .swift
//  FirebaseProject
//
//  Created by mobin on 1/13/23.
//

import Foundation

struct UserModel {
    var fullName: String
    var password: String
    var email:String
       
    var safeEmail:String {
        let safeEmail = email.replacingOccurrences(of: ".", with: "-", options: .literal, range: nil)
        return safeEmail
    }
    var phoneNumber:String 
}
