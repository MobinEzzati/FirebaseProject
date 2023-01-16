//
//  DatabaseManager.swift
//  FirebaseProject
//
//  Created by mobin on 1/13/23.
//        var safeEmail = user.email.replacingOccurrences(of: ".", with: "-", options: .literal, range: nil)
//            safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-", options: .literal, range: nil)

import Foundation
import FirebaseDatabase

final class DatabaseManagment{
    static var db = DatabaseManagment()
    var database = Database.database().reference()
}

extension DatabaseManagment{

    public func userExists(User user: UserModel,completion: @escaping((String) -> Void)){
        
        
        print(user.safeEmail)

        database.child(user.safeEmail).observeSingleEvent(of: .value) {[weak self] snapShot in
            if(snapShot.exists()){
                completion("we already have your email")
                
            }else {
                self!.insertUser(user: user)
                completion("your info added")
            }
        }

        }

    private func insertUser (user : UserModel ) {
        
        
        database.child(user.safeEmail).setValue([
            "fullName": user.fullName,
            "password": user.password,
            "phoneNumber":user.phoneNumber

        ])
        
     }
    
    
    func fetchUserData(email:String, completion:@escaping(([String:String]) -> Void)){
        
        database.child(email).observe(.value) { DataSnapshot in
            
            let userData = DataSnapshot.value as? [String : String] ?? [:]

                 completion(userData)
            //            userData["email"] = (DataSnapshot.value(forKey: "email") as! String)
//            userData["fullName"] = (DataSnapshot.value(forKey: "fullName") as! String)
//            userData["phoneNumber"] = (DataSnapshot.value(forKey: "phoneNumber") as! String)

        }
//        completion(userData)
    }
}
