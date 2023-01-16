//
//  RegisterViewModel.swift
//  FirebaseProject
//
//  Created by mobin on 1/13/23.
//

import Foundation
//import FirebaseCore

//
//import FirebaseAuth
//import FirebaseFirestore

struct RegisterViewModle{
    var  user : UserModel!
    func checkUserAndsignUp( user:UserModel,completetionHandler:@escaping((String) -> Void)){
        DatabaseManagment.db.userExists(User: user) { String in
            completetionHandler(String)
        }
    }
    
    
    mutating func getUserData(email:String , completetionHandler:@escaping((UserModel) -> Void)) {
        
        
        DatabaseManagment.db.fetchUserData(email: email) { (userData: [String : String])in
    
            completetionHandler(UserModel(fullName: userData["fullName"]!,
                                          password: userData["password"]!,
                                          email: email,
                                          phoneNumber: userData["phoneNumber"]!))
        }
    }
   
  
    
        
    }
    

