//
//  LoginVC.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 2/27/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import UIKit
class LoginVC: UIViewController {
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        Client.getRequestToken(completionHandler: self.handleTokenResponse(success:error:))
    }
    
    func handleTokenResponse(success:Bool,error:Error?){
        if success{
            print(Client.Auth.requestToken)
            DispatchQueue.main.async {
                Client.login(username: self.usernameTxtField.text ?? "", password: self.passwordTxtField.text ?? "", completionHandler: self.handleLoginResponse(success:error:))
            }
        }
        else{
            print(error!)
            
        }
    }
    
    func handleLoginResponse(success:Bool,error:Error?){
        if success{
            print(Client.Auth.requestToken)
            Client.requestSessionId(completionHandler: handleSessionIdResponse(success:error:))
        }
        else{
            print(error!)
            
        }
    }
    
    func handleSessionIdResponse(success:Bool,error:Error?){
        if success{
            print(Client.Auth.sessionId)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)

            }
        }
        else{
            print(error!)
        }
    }



}

