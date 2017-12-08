//
//  ChatViewController.swift
//  Multipeer_Connectivity
//
//  Created by Lars De Winter on 01/12/2017.
//  Copyright © 2017 Lars De Winter. All rights reserved.
//

import UIKit
var appDelegate: AppDelegate?
import MultipeerConnectivity

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblChat: UITableView!
    var messagesArray: [Dictionary<String, String>] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var textField: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell")!
        
        let currentMessage = messagesArray[indexPath.row] as Dictionary<String, String>
        
        if let sender = currentMessage["sender"] {
            var senderLabelText: String
            var senderColor: UIColor
            
            if sender == "self"{
                senderLabelText = "I said:"
                senderColor = UIColor.purple
            }
            else{
                senderLabelText = sender + " said:"
                senderColor = UIColor.orange
            }
            
            cell.detailTextLabel?.text = senderLabelText
            cell.detailTextLabel?.textColor = senderColor
        }
        
        if let message = currentMessage["message"] {
            cell.textLabel?.text = message
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblChat.delegate = self
        tblChat.dataSource = self
        tblChat.estimatedRowHeight = 60.0
        tblChat.rowHeight = UITableViewAutomaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(handleMPCReceivedDataWithNotification), name: Notification.Name("receivedMPCDataNotification"), object: nil)
        textField.delegate = self
        // Do any additional setup after loading the view.
    }

    @objc func handleMPCReceivedDataWithNotification(notification: NSNotification) {
        // Get the dictionary containing the data and the source peer from the notification.
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        
        // "Extract" the data and the source peer from the received dictionary.
        let data = receivedDataDictionary["data"] as? NSData
        let fromPeer = receivedDataDictionary["fromPeer"] as! MCPeerID
        
        // Convert the data (NSData) into a Dictionary object.
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as! Dictionary<String, String>
        
        // Check if there's an entry with the "message" key.
        if let message = dataDictionary["message"] {
            // Make sure that the message is other than "_end_chat_".
            if message != "_end_chat_"{
                // Create a new dictionary and set the sender and the received message to it.
                let messageDictionary: [String: String] = ["sender": fromPeer.displayName, "message": message]
                
                // Add this dictionary to the messagesArray array.
                messagesArray.append(messageDictionary)
                
                // Reload the tableview data and scroll to the bottom using the main thread.
                OperationQueue.main.addOperation({ () -> Void in
                    self.updateTableview()
                })
            }
            else{
                // In this case an "_end_chat_" message was received.
                // Show an alert view to the user.
                let alert = UIAlertController(title: "", message: "\(fromPeer.displayName) ended this chat.", preferredStyle: UIAlertControllerStyle.alert)
                
                let doneAction: UIAlertAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                    self.appDelegate.mcManager.session.disconnect()
                    self.dismiss(animated: true, completion: nil)
                }
                
                alert.addAction(doneAction)
                
                OperationQueue.main.addOperation({ () -> Void in
                    self.present(alert, animated: true, completion: nil)
                })
            }
        }
    }

    @IBAction func cancelMessage(_ sender: UIButton) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let messageDictionary: [String: String] = ["message": textField.text!]
        
        if appDelegate.mcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mcManager.session.connectedPeers[0] as MCPeerID){
            
            let dictionary: [String: String] = ["sender": "self", "message": textField.text!]
            messagesArray.append(dictionary)
            
            self.updateTableview()
        }
        else{
            print("Could not send data")
        }
        
        textField.text = ""
        
        return true
    }
    
    func updateTableview(){
        self.tblChat.reloadData()
        
        if self.tblChat.contentSize.height > self.tblChat.frame.size.height {
            tblChat.scrollToRow(at: NSIndexPath(row: messagesArray.count - 1, section: 0) as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
        }
    }
    
    @IBAction func endChat(sender: AnyObject) {
        let messageDictionary: [String: String] = ["message": "_end_chat_"]
        if appDelegate.mcManager.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.mcManager.session.connectedPeers[0] as MCPeerID){
            self.dismiss(animated: true, completion: { () -> Void in
                self.appDelegate.mcManager.session.disconnect()
            })
        }
    }
    
    
}
