//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Tianyu Liang on 3/4/18.
//  Copyright © 2018 Tianyu Liang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatMessageField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    var messages: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
        // refresh
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (ChatViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0);
        updateMessage()
        // Do any additional setup after loading the view.
    }
    func updateMessage(){
        // construct PFQuery
        let query = Message.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("user")
        query?.limit = 50
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (messages, error) in
            if messages != nil {
                // do something with the data fetched
                self.messages = messages!
                self.tableView.reloadData()
                self.refreshControl.endRefreshing();
            } else {
                // handle error
            }
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        chatMessageField.isEnabled = false
        chatMessageField.isEnabled = true
    }
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.row]
        cell.textMessage.text = message["text"] as? String
        
        if let user = message["user"] as? PFUser {
            // User found! update username label with username
            cell.user.text = user.username
        } else {
            // No user found, set default username
            cell.user.text = "🤖"
        }
        return cell
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        updateMessage();
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
