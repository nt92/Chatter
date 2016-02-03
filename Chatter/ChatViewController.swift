//
//  ChatViewController.swift
//  Chatter
//
//  Created by Nikhil Thota on 2/2/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatMessage: UITextField!
    
    var messages: [PFObject]! = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell") as! ChatCell
        cell.messageLabel.text = message["text"] as! String!
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func onSend(sender: AnyObject) {
        let message = PFObject(className:"Message")
        message["text"] = chatMessage.text
        message["user"] = PFUser.currentUser()
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("Saved")
                self.queryMessages()
            } else {
                print(error?.description)
            }
        }
    }
    
    func onTimer() {
        self.tableView.reloadData()
    }
    
    func queryMessages(){
        let query = PFQuery(className:"Message")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            self.messages = objects! as [PFObject]
            self.tableView.reloadData()
        }
    }
}
