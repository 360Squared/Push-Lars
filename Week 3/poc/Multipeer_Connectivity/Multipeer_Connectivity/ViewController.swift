//
//  ViewController.swift
//  Multipeer_Connectivity
//
//  Created by Lars De Winter on 30/11/2017.
//  Copyright © 2017 Lars De Winter. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MPCManagerDelegate {
    @IBOutlet weak var tblPeer: UITableView!
    var isAdvertising: Bool!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.mcManager.foundPeers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellPeer")!
        
        cell.textLabel?.text = appDelegate.mcManager.foundPeers[indexPath.row].displayName
        return cell
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPeer = appDelegate.mcManager.foundPeers[indexPath.row] as MCPeerID
        
        appDelegate.mcManager.browser.invitePeer(selectedPeer, to: appDelegate.mcManager.session, withContext: nil, timeout: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.mcManager.delegate = self
        tblPeer.delegate = self
        tblPeer.dataSource = self
        appDelegate.mcManager.browser.startBrowsingForPeers()
        appDelegate.mcManager.advertiser.startAdvertisingPeer()
        isAdvertising = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func foundPeer() {
        tblPeer.reloadData()
    }
    
    func lostPeer() {
        tblPeer.reloadData()
    }
    
    @IBAction func startStopAdvertising(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "", message: "Change Visibility", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        var actionTitle: String
        if isAdvertising == true {
            actionTitle = "Make me invisible to others"
        }
        else{
            actionTitle = "Make me visible to others"
        }
        
        let visibilityAction: UIAlertAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default) { (alertAction) -> Void in
            if self.isAdvertising == true {
                self.appDelegate.mcManager.advertiser.stopAdvertisingPeer()
            }
            else{
                self.appDelegate.mcManager.advertiser.startAdvertisingPeer()
            }
            
            self.isAdvertising = !self.isAdvertising
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(visibilityAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func invitationWasReceived(fromPeer: String) {
        let alert = UIAlertController(title: "", message: "\(fromPeer) wants to chat with you.", preferredStyle: UIAlertControllerStyle.alert)
        
        let acceptAction: UIAlertAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            self.appDelegate.mcManager.invitationHandler(true, self.appDelegate.mcManager.session)
        }
        
        let declineAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            self.appDelegate.mcManager.invitationHandler(false, nil)
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        OperationQueue.main.addOperation { () -> Void in
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func connectedWithPeer(peerID: MCPeerID) {
        OperationQueue.main.addOperation { () -> Void in
            self.performSegue(withIdentifier: "idSegueChat", sender: self)
        }
    }
}

