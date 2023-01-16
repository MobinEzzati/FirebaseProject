//
//  ViewController.swift
//  FirebaseProject
//
//  Created by mobin on 1/13/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
 

class ViewController: UIViewController {
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    var viewModel = RegisterViewModle()
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneTextField.delegate = self
        
        

       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        initUi()
    }
    
    func initUi(){
        fullNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        phoneTextField.text = ""
    }
    
    
    

    
    @IBAction func SignUp(_ sender: UIButton) {
        var userTest = UserModel(
            fullName: fullNameTextField.text ?? "nil",
            password: passwordTextField.text ?? "nil",
            email: emailTextField.text ?? "nil",
            phoneNumber: phoneTextField.text ?? "nil")
        
        viewModel.checkUserAndsignUp(user: userTest) { String in
            var d = String
            if d == Constants.negativeMessage {
                let alert = UIAlertController(title: "Alert", message: "we already have your email.", preferredStyle: .alert)

                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)

                self.present(alert, animated: true, completion: nil)
            }else {
                self.viewModel.getUserData(email: userTest.safeEmail) { UserModel in
                    userTest.email = UserModel.email
                    userTest.fullName = UserModel.fullName
                    userTest.phoneNumber = UserModel.phoneNumber
                    userTest.password = UserModel.password
                }
                    let detailVc = self.storyboard?.instantiateViewController(withIdentifier:Constants.detailVc ) as! DetailViewController
                    
                    detailVc.userDetail =  userTest
                    self.navigationController?.pushViewController(detailVc, animated: true)
             

                
            }
        }
        
    }
    
}

extension ViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
       return true
    }
    
}

