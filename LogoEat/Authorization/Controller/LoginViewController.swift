//
//  LoginViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 18.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
        touchupLoginScreen()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func touchupLoginScreen() {
        loginButton.layer.cornerRadius = 5
        loginButton.layer.backgroundColor = UIColor(red: 0.506, green: 0.698, blue: 0.604, alpha: 1).cgColor
        signupButton.layer.backgroundColor = UIColor(red: 0.335, green: 0.35, blue: 0.488, alpha: 1).cgColor
        signupButton.layer.cornerRadius = 5
        emailTextField.layer.cornerRadius = 8
        passwordTextField.layer.cornerRadius = 8
    }
    
    @objc func login (sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else {return}
        
        let group = DispatchGroup()
        group.enter()
        AuthorizationNetworkService.login(email: email, password: password) {(dict) in
            guard let token = dict["token"] as? String else {return}
            Token.token = token;
            group.leave()
        }
        
        group.notify(queue: .main){
            if Token.token != nil {
                let storyboard = UIStoryboard(name: "Restaurant", bundle: .main)
                let controller = storyboard.instantiateViewController(withIdentifier: "tabBarController")
                UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.5, options: .transitionFlipFromTop,
                                  animations: {
                                    UIApplication.shared.keyWindow!.rootViewController = controller
                                  })
            }
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
