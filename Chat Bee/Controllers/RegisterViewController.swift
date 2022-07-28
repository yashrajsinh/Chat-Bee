//
//  RegisterViewController.swift
//  Chat Bee
//  Coded By Vishwash Dhiman, RegisterViewController Storyboard is created by Vishwas too
/*
 This screen has 2 fields 1 for user' email and 1 for password
 and one button in order to register new user
 */

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    //Fields for email,password
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //This Method is For Register Button
    @IBAction func registerPressed(_ sender: UIButton) {
       //Check Both Fields are empty or not
        if let email = emailTextfield.text,let pass = passwordTextfield.text
        {
            //Using Fire Base Method Creating new user
            Auth.auth().createUser(withEmail: email, password: pass) { result, error in
            if let e = error{
                //Error
                print(e.localizedDescription)
            }else{
                //For Chat Screen
                self.performSegue(withIdentifier: "RegisterToChat", sender: self)
            }
        }
      
        }//condition
        
    }//func
}
