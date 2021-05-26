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
    @IBOutlet var emailError: UILabel!
    @IBOutlet var messageView: UIView!
    
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    var userCreated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showMessage), name:NSNotification.Name(rawValue: "showMessage"), object: nil)
        loginButton.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
        touchupLoginScreen()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc func showMessage() {
        messageView.animShow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userCreated == true {
            messageView.animShow()
        }
    }
    //MARK: - Logic
    
    func validate() -> Bool{
        if emailTextField.text != nil{
            if emailTextField.text!.matches(emailRegex) {
                emailError.isHidden = true
                return true
            } else {
                emailError.isHidden = false
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.07
                animation.repeatCount = 4
                animation.autoreverses = true
                animation.fromValue = NSValue(cgPoint: CGPoint(x: emailError.center.x - 10, y: emailError.center.y))
                animation.toValue = NSValue(cgPoint: CGPoint(x: emailError.center.x + 10, y: emailError.center.y))

                emailError.layer.add(animation, forKey: "position")
                return false
            }
        }
        return false
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
        if validate(){
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
                    let controller = storyboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                    controller.selectedIndex = 1
                    UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.5, options: .transitionFlipFromTop,
                                      animations: {
                                        UIApplication.shared.keyWindow!.rootViewController = controller
                                      })
                    
                }
            }
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

// MARK: - Extension

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
}
