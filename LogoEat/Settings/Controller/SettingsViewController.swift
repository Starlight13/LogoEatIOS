//
//  SettingsViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 18.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var likedRestaurantsButton: UIButton!
    @IBOutlet var changeNameButton: UIButton!
    @IBOutlet var changeNumberButton: UIButton!
    @IBOutlet var changePassword: UIButton!
    @IBOutlet var logoutButton: UIButton!
    
    let user = User(name: "Olga", phone: "+38(067)-111-11-11", email: "email@gmail.com", likedRestaurants: [Restaurant(name: "Pototski", rating: 9.0, cuisine: "Ukrainian, Italian", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque commodo velit ut quam ullamcorper porttitor.", location: "Khmelnystsky, Proskurivska, 45", image: "Pototski")])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingsScreen()
        logoutButton.addTarget(self, action: #selector(logout(sender:)), for: .touchUpInside)
    }
    
    func setupSettingsScreen() {
        
        avatarImage.layer.masksToBounds = false
        avatarImage.layer.cornerRadius = avatarImage.frame.height/2
        avatarImage.clipsToBounds = true
        
        nameLabel.text = user.name
        phoneLabel.text = user.phone
    }
    
    @objc func logout (sender: UIButton) {
        Token.token = nil
        if !(Token.token == nil) {return}
        let storyboard = UIStoryboard(name: "Authorization", bundle: .main)

        UIView.transition(with: UIApplication.shared.keyWindow!, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            UIApplication.shared.keyWindow!.rootViewController = storyboard.instantiateViewController(withIdentifier: "loginViewController")
            })
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "likedSegue" {
            let newDetailVC = segue.destination as! LikedTableViewController
            newDetailVC.likedRestaurants = user.likedRestaurants
        } else {
            let newChangeVC = segue.destination as! ChangeViewController
            switch segue.identifier {
            case "nameSegue":
                newChangeVC.changeType = ChangeType.name
            case "phoneSegue":
                newChangeVC.changeType = ChangeType.phone
            default:
                newChangeVC.changeType = ChangeType.password
            }
        }
    }


}
