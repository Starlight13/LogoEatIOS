//
//  SettingsViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 18.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.addTarget(self, action: #selector(logout(sender:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func logout (sender: UIButton) {
        User.token = nil
        if !(User.token == nil) {return}
        let storyboard = UIStoryboard(name: "Authorization", bundle: .main)

        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.5, options: .transitionFlipFromTop, animations: {
            UIApplication.shared.keyWindow!.rootViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
            })
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
