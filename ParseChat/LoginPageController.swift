//
//  LoginPageController.swift
//  ParseChat
//
//  Created by Nanxin Jin on 2/23/17.
//  Copyright © 2017 jinn. All rights reserved.
//

import UIKit
import Parse

class LoginPageController: UIViewController {

    @IBOutlet weak var UserNameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        do{
            
            try PFUser.logIn(withUsername: UserNameText.text!, password: PasswordText.text!)
            self.performSegue(withIdentifier: "toChat", sender: nil)
        }
        catch{
            print(error)
            let alertController = UIAlertController(title: "Login Failed", message: "User Name or Password Wrong!", preferredStyle: .alert)
            // add the cancel action to the alertController
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            // Do any additional setup after loading the view.
            self.present(alertController, animated: true) {
        }
    }

    func onClickSignUp(_ sender: Any) {
        signup()
        
    }
    func keyboardWillShow(notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y -= keyboardSize.height
            print(keyboardSize.height)
        }
        
    }
    
    func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y += keyboardSize.height
            print(keyboardSize.height)
        }
    }
    
    func signup() {
        let user = PFUser()
        user.username = UserNameText.text!
        user.password = PasswordText.text!
        user.signUpInBackground { (success: Bool, error: Error?) in
            if success == true {
                print("Success")
                self.performSegue(withIdentifier: "toChat", sender: nil)
            } else {
                let alertController = UIAlertController(title: "SignUp Failed", message: "\(error!.localizedDescription)", preferredStyle: .alert)
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

                print(error!.localizedDescription)
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
}
