//
//  LoginViewController.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/6/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var UserNameText: UITextField!
    
    @IBOutlet weak var PasswordText: UITextField!
    
    
    @IBAction func Login(_ sender: UIButton) {
        guard let email = UserNameText.text, email != "" else {
            //show error
            let alert = Utils.createAlert("Login Error", message: "Please provide a UserName", dismissButtonTitle: "Close")
            present(alert, animated: true, completion: nil)
            //need return or it just keeps on going on
            return
        }
        
        guard let password = PasswordText.text, password != ""
            else {
                present(Utils.createAlert("Login Error", message: "Please provide a valid Password"), animated: true, completion: nil)
                return
        }
        //Going to go ahead with the register save
        
        //show something on screen that shows what we are doing-- HUD--heads up display
        MBProgressHUD.showAdded(to: view, animated: true)    //this is the spinny wheel
        
        
        let user = User(email: email, password: password)
        
        UserStore.shared.login(user) { (success, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            
            //if success going back to main
            if success{
                self.dismiss(animated: true, completion: nil)
                
            }else if let error = error {
                self.present(Utils.createAlert(message: error), animated: true, completion: nil)
                
            }else{
                self.present(Utils.createAlert(message: Constants.JSON.unknownError), animated: true, completion: nil)
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
