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
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var errorView: UIView!
    
    var message: String?
    
    let nameRegex = "^[a-z а-я A-Z А-Я,.'-]{3,}$"
    let phoneRegex = "^\\+380[\\d]{9}$"
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=\\S+$).{8,}$"
    
    
    
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
            guard let email = emailTextField.text, let phoneNumber = phoneNumberTextField.text, let name = nameTextField.text, let password = passwordTextField.text else {return}
            let group = DispatchGroup()
            group.enter()
            AuthorizationNetworkService.signup(name: name, phoneNumber: phoneNumber, email: email, password: password) { (dict) in
                guard let message = dict["message"] as? String else {return}
                self.message = message
                group.leave()
            }

            group.notify(queue: .main){
                if self.message == "User is successful Registered." {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showMessage"), object: nil)
                    self.dismiss(animated: true, completion: nil)
                    return
                }
                self.errorLabel.text = self.message
                self.errorView.animShow()
            }
        } else {
            shake(errorLabel: nameError)
            shake(errorLabel: phoneError)
            shake(errorLabel: emailError)
            shake(errorLabel: passwordError)
        }
        
    }
    
    //MARK: - Validation
    
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
                return validate(textField: passwordTextField, regex: passwordRegex, errorLabel: passwordError)
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

extension UIView{
    func animShow(){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y += self.bounds.height-40
                        self.layoutIfNeeded()
                       }) { truth in
            self.animHide()
        }
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 0.5, delay: 3, options: [.curveLinear],
                       animations: {
                        self.center.y -= self.bounds.height-40
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
}
