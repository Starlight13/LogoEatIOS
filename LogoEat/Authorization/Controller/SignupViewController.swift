//
//  SignupViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 19.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var nameError: UILabel!
    @IBOutlet var phoneError: UILabel!
    @IBOutlet var emailError: UILabel!
    @IBOutlet var passwordError: UILabel!
    
    let nameRegex = "^[a-z а-я A-Z А-Я,.'-]{3,}$"
    let phoneRegex = "^[0-9]{10}$|^+380[0-9]{9}$"
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.addTarget(self, action: #selector(signup(sender:)), for: .touchUpInside)
        
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupPhonePad()
        touchupLoginScreen()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Logic
    @objc func signup(sender: UIButton) {
        if allIsValid() {
            self.dismiss(animated: true, completion: nil)
        } else{
            shake(errorLabel: nameError)
            shake(errorLabel: phoneError)
            shake(errorLabel: emailError)
            shake(errorLabel: passwordError)
        }
        
    }
    
    func shake(errorLabel: UILabel) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: errorLabel.center.x - 10, y: errorLabel.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: errorLabel.center.x + 10, y: errorLabel.center.y))

        errorLabel.layer.add(animation, forKey: "position")
    }
    
    func validate(textField: UITextField, regex: String, errorLabel: UILabel) -> Bool {
        if textField.text!.matches(regex) {
            errorLabel.isHidden = true
        } else {
            errorLabel.isHidden = false
            return false
        }
        return true
    }
    
    func validateTextField(textField: UITextField) -> Bool {
        if textField.text != nil {
            switch textField.tag {
            case 0:
                return validate(textField: textField, regex: nameRegex, errorLabel: nameError)
            case 1:
                return validate(textField: phoneNumberTextField, regex: phoneRegex, errorLabel: phoneError)
            case 2:
                return validate(textField: emailTextField, regex: emailRegex, errorLabel: emailError)
            case 3:
                if passwordTextField.text!.count > 6 {
                    passwordError.isHidden = true
                    return true
                } else{
                    passwordError.isHidden = false
                    return false
                }
            default:
                return true
            }
        }
        return false
    }
    
    func allIsValid() -> Bool {
        var flag = true
        let textFields = [nameTextField, phoneNumberTextField, emailTextField, passwordTextField]
        for textField in textFields {
            if !validateTextField(textField: textField!) {flag = false}
        }
        return flag
    }
    
    
    
    // MARK: - Setup
    
    func touchupLoginScreen() {
        signupButton.layer.cornerRadius = 5
        signupButton.layer.backgroundColor = UIColor(red: 0.506, green: 0.698, blue: 0.604, alpha: 1).cgColor
        
        emailTextField.layer.cornerRadius = 8
        phoneNumberTextField.layer.cornerRadius = 8
        passwordTextField.layer.cornerRadius = 8
        nameTextField.layer.cornerRadius = 8
        
    }
    
    func setupPhonePad(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace ,doneButton], animated: true)
        self.phoneNumberTextField.inputAccessoryView = toolbar
    }
    
    @objc func done() {
        phoneNumberTextField.endEditing(true)
    }

}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = validateTextField(textField: textField)
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
}
