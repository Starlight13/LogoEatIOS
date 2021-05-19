//
//  SignupViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 19.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.addTarget(self, action: #selector(signup(sender:)), for: .touchUpInside)
        
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        touchupLoginScreen()
        // Do any additional setup after loading the view.
    }
    
    @objc func signup(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func touchupLoginScreen() {
        signupButton.layer.cornerRadius = 5
        signupButton.layer.backgroundColor = UIColor(red: 0.506, green: 0.698, blue: 0.604, alpha: 1).cgColor
        
        emailTextField.layer.cornerRadius = 8
        phoneNumberTextField.layer.cornerRadius = 8
        passwordTextField.layer.cornerRadius = 8
        nameTextField.layer.cornerRadius = 8
        
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
