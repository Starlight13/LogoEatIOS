//
//  LoginViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 18.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
    }
    
    @objc func login (sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else {return}
        
        AuthorizationNetworkService.login(email: email, password: password) {(dict) in
            guard let token = dict["token"] as? String else {return}
            User.token = token;
        }
        print(User.token)
        if User.token != nil {
            let storyboard = UIStoryboard(name: "Restaurant", bundle: .main)
            let controller = storyboard.instantiateViewController(withIdentifier: "tabBarController")
            UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.5, options: .transitionFlipFromTop,
                                  animations: {
                                    UIApplication.shared.keyWindow!.rootViewController = controller
                })
        }
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
