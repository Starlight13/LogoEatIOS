//
//  BookViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 19.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    var currentRestaurant: Restaurant?
    
    @IBOutlet var bookingPlaceLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var numberOfPeopleTextField: UITextField!
    @IBOutlet var bookButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookButton.addTarget(self, action: #selector(book(sender:)), for: .touchUpInside)
        setupBookScreen()
    }
    
    func  setupBookScreen () {
        bookButton.layer.cornerRadius = 5
        
        nameTextField.layer.cornerRadius = 8
        dateTextField.layer.cornerRadius = 8
        numberOfPeopleTextField.layer.cornerRadius = 8
        
        bookingPlaceLabel.textColor = .white
        
        if currentRestaurant != nil {
            bookingPlaceLabel.text = "Booking \(currentRestaurant?.name ?? "restaurant")"
        }
    }
    
    @objc func book(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
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
