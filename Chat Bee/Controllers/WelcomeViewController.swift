//
//  WelcomeViewController.swift
//  Chat Bee
//
// Coded By Jesus, Welcome Storyboard is created by jesus too
//
/*
 This is Main Screen once application is booted up user will see this screen
 It has 2 buttons and 1 label button for Register and Log In Label is Application name
*/
import UIKit
import CLTypingLabel
class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //First Page Of Application With Label 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This is for an Animation
        titleLabel.text = "ChatBee🐝"
    }
    
}
