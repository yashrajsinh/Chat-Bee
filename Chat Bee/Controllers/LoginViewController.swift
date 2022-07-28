//
//  LoginViewController.swift
//  Chat Bee
//  Coded By Krishna Thakor, LoginViewController Stoaryboard is created by Krishna too

/*
    This screen is Log In Screen where existing user can log in
    it has 2 fields(Email,password) and 1 button
    There is also a method for validation
 */

import UIKit
import Firebase

class LoginViewController: UIViewController {
    //Email,password Fields
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        //For exisitng user
        if let email = emailTextfield.text, let pass = passwordTextfield.text
        {
            if(email.isEmpty==true || pass.isEmpty == true){
                self.ErrorMessage(error: "Please Fill Out Empty Fields")
            }
            else{
                //Firebase Method To fetch existing user using email and password
                Auth.auth().signIn(withEmail: email, password: pass) {result, error in
                    if let e = error{
                        self.ErrorMessage(error: "Wrong Username or Password ")
                        print("Error " + e.localizedDescription)
                    }
                    else{
                        self.performSegue(withIdentifier: "LoginToChat", sender: self)
                    }
                }
              }
            }
        }
    
    //For Error Message
    func  ErrorMessage(error: String){
        let alert = UIAlertController.init(title: "Error", message: error, preferredStyle: .alert)
        
        //Dismiss Button
        let Dismiss = UIAlertAction.init(title: "Dismiss", style: .default, handler: nil)
        
        //Add Dismiss Button
        alert.addAction(Dismiss)
        
        self.present(alert, animated: true, completion: nil)
    }

       
}

