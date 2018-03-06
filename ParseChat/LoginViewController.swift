//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Tianyu Liang on 3/4/18.
//  Copyright © 2018 Tianyu Liang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    let alertController = UIAlertController(title: "Invalid Input", message: "Username or password can't be empty", preferredStyle: .alert)
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success, error) in
            if(success){
                print("user created")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("user not created")
                self.alertController.title = "registration failed"
                self.alertController.message = error?.localizedDescription
                self.present(self.alertController, animated: true, completion: {
                })
            }
        }
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        if(passwordField.text! == "" || usernameField.text! == ""){
            present(alertController, animated: true, completion: {
                
            })
        }
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) {
            (user, error) in
            if(user != nil){
                print("successful login")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                self.alertController.title = "login failed"
                self.alertController.message = error?.localizedDescription
                self.present(self.alertController, animated: true, completion: {
                })
            }
        }
    }
    // create a cancel action
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        // handle cancel response here. Doing nothing will dismiss the view.
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
