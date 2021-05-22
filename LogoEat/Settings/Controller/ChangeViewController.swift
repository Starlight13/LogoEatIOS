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
    
    @IBOutlet var changeView: UIView!
    @IBOutlet var changeLabel: UILabel!
    @IBOutlet var changeField: UITextField!
    @IBOutlet var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeButton.addTarget(self, action: #selector(makeChange), for: .touchUpInside)
        setupChangeScreen()
    }
    
    // TODO: - Pass change to server
    @objc func makeChange() {
        self.dismiss(animated: true, completion: nil)
    }
    
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
