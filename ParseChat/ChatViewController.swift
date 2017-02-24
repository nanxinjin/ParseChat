//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Nanxin Jin on 2/23/17.
//  Copyright © 2017 jinn. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController , UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    var Messages : [PFObject] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.reloadData()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        
    }

    func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className:"Messagejnx")
        query.order(byAscending: "createdAt")
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) in
            if error == nil{
                self.Messages = messages!
                
            }else{
                print("Error:")
            }
        }
        
        self.tableView.reloadData()
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Messages != nil {
            return Messages.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = Messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! messageCell
        
        cell.messageLable.text = message["text"] as! String?
        cell.userLabel.text = message["user1"] as! String?
        return cell
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendAction(_ sender: Any) {
        let message = PFObject(className:"Messagejnx")
        message["user1"] = PFUser.current()?.username
        message["text"] = textInput.text!
        message.saveInBackground { (success: Bool, error: Error?) in
            if success == true{
                print("\(self.textInput.text!)")
            }else{
                let alertController = UIAlertController(title: "Text Wrong", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                // add the cancel action to the alertController
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                // Do any additional setup after loading the view.
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }

            }
        }
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
