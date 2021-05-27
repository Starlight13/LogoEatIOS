//
//  ChangeViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 22.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController, UITextFieldDelegate {
    
    var changeType: ChangeType?
    var message: String?
    
    
    @IBOutlet var changeView: UIView!
    @IBOutlet var changeLabel: UILabel!
    @IBOutlet var changeField: UITextField!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var validationError: UILabel!
    
    let nameRegex = "^[a-z а-я A-Z А-Я,.'-]{3,}$"
    let phoneRegex = "^\\+380[\\d]{9}$"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButton.addTarget(self, action: #selector(makeChange), for: .touchUpInside)
        changeField.delegate = self
        setupChangeScreen()
    }
    
   
    //MARK: - Logic
    
    // TODO: - Pass change to server
    @objc func makeChange() {
        if validateTextField() {
            switch changeType {
            case .name:
                changeName(name: changeField.text!)
            case .phone:
                changePhoneNumber(phoneNumber: changeField.text!)
            case .password:
                changePassword(password: changeField.text!)
            default:
                print("Not done")
            }
            self.dismiss(animated: true, completion: nil)
        } else {
            shake(errorLabel: validationError)
        }
        
    }
    
    
    private func changeName(name: String){
        let group = DispatchGroup()
        group.enter()
        SettingsNetworkService.makeChangeRequest(parameters: ["name": name], requestUrl: "update_name") { (dict) in
            guard let message = dict["message"] as? String else {return}
            self.message = message
            group.leave()
        }

        group.notify(queue: .main){
            if self.message == "Name was changed." {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccessView"), object: nil)
                self.dismiss(animated: true, completion: nil)
                return
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showFailureView"), object: nil)
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
    
    private func changePhoneNumber(phoneNumber: String){
        let group = DispatchGroup()
        group.enter()
        SettingsNetworkService.makeChangeRequest(parameters: ["phoneNumber": phoneNumber], requestUrl: "update_phone_number") { (dict) in
            guard let message = dict["message"] as? String else {return}
            self.message = message
            group.leave()
        }

        group.notify(queue: .main){
            if self.message == "Number was changed." {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccessView"), object: nil)
                self.dismiss(animated: true, completion: nil)
                return
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showFailureView"), object: nil)
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
    
    private func changePassword(password: String){
        let group = DispatchGroup()
        group.enter()
        SettingsNetworkService.makeChangeRequest(parameters: ["password": password], requestUrl: "update_password") { (dict) in
            guard let message = dict["message"] as? String else {return}
            self.message = message
            group.leave()
        }

        group.notify(queue: .main){
            if self.message == "Password was changed." {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSuccessView"), object: nil)
                self.dismiss(animated: true, completion: nil)
                return
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showFailureView"), object: nil)
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
    
    //MARK: -Validation
    
    func validate(textField: UITextField, regex: String, errorLabel: UILabel) -> Bool {
        if textField.text!.matches(regex) {
            errorLabel.isHidden = true
        } else {
            errorLabel.isHidden = false
            return false
        }
        return true
    }
    
    func validateTextField() -> Bool{
        if changeField.text != nil{
            switch changeType {
            case .name:
                if !validate(textField: changeField, regex: nameRegex, errorLabel: validationError) {
                    validationError.text = "Enter valid name"
                    return false
                } else {return true}
            case .phone:
                if !validate(textField: changeField, regex: phoneRegex, errorLabel: validationError) {
                    validationError.text = "Valid format: +380*******"
                    return false
                } else {return true}
            case .password:
                if changeField.text!.count < 6 {
                    validationError.text = "The password is too short"
                    validationError.isHidden = false
                    return false
                } else {
                    validationError.isHidden = true
                    return true
                }
            default:
                return false
            }
        }
        return false
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
    
    //MARK: -Setup
    
    func setupChangeScreen() {
        guard changeType != nil else {return}
        switch changeType {
        case .name:
            changeLabel.text = "Change name"
            changeField.placeholder = "Enter new name"
        case .phone:
            changeLabel.text = "Change phone number"
            changeField.placeholder = "Enter new phone number"
            changeField.keyboardType = .phonePad
        case .password:
            changeLabel.text = "Change password"
            changeField.placeholder = "Enter new password"
            changeField.isSecureTextEntry = true
        default:
            return
        }
        return
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != changeView {
                self.dismiss(animated: true, completion: nil)
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
