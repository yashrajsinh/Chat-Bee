//
//  ChatViewController.swift
//  Chat Bee
//
//  Created by Yashrajsinh Jadeja
//  and Coded By Yashrajsinh Jadeja (ChatViewController,Message.swift,MesssageCell,MessageCell.nib)
//
/*
    This is main part of chat application where all magic happens using table view and some firebase method user can send and recieve a message
 */

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    //Array Of Message
    var messages: [Message] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //Title Of Screen
        title = "Chatroom"
        tableView.dataSource = self
        
        //TO Hide Back Button
        navigationItem.hidesBackButton = true
        
        //This is for Custom Bobble in Chat
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        //Method To Fetch All Messages
        loadMessages()
    }
    
    
    func loadMessages(){
        //Firebase method to fetch all data from database
        db.collection(k.Fstore.collectionName)
            .order(by: k.Fstore.dateField)
            .addSnapshotListener { querySnap, error in
            self.messages = []
            //In Case Of Error
            if let e = error{
                print("error")
            }
            //Otherwise it will load all chats
            else{
                if let snapDoc = querySnap?.documents {
                    for doc in snapDoc {
                        let data = doc.data()
                        if let sender = data[k.Fstore.senderField] as? String,let msgBody = data[k.Fstore.bodyField] as? String{
                            let newMsg = Message(sender: sender, body: msgBody)
                            self.messages.append(newMsg)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //For sending Message
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text,let messerSender = Auth.auth().currentUser?.email{
            db.collection(k.Fstore.collectionName).addDocument(data:
                [k.Fstore.senderField:messerSender,
                 k.Fstore.bodyField: messageBody,
                 k.Fstore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                //Print Error On Console In Case of error
                if let e = error{
                    print("Error ")
                }
                else {
                    print("Saved")
                    DispatchQueue.main.async {
                        //Once Text sent clean field
                        self.messageTextfield.text = ""
                    
                    }
                }
            }
        }
    }
    
    //Log Out User
    @IBAction func logOutPressed(_ sender: Any) {
        do{
            //Firebase Method To LogOut User
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        }catch let signOutError as NSError{
            //Print Error On Console
           print("Error ",signOutError)
        }
    }
}

//Extension Of chatview
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return Count as per message numbers
        return messages.count
    }
    
    //function for tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        cell.label.text = message.body
        //For hidding sender details during chat
        if message.sender == Auth.auth().currentUser?.email{
            DispatchQueue.main.async {
                cell.leftImage.isHidden = true
                cell.rightImage.isHidden = false
                cell.messageBobble.backgroundColor = .systemBlue
                cell.label.textColor = .white
            }
           }
        else
        {
            DispatchQueue.main.async {
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.messageBobble.backgroundColor = .purple
            cell.label.textColor = .white
            }
        }
        return cell
    }
  }

    

