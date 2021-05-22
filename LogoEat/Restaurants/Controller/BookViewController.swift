//
//  BookViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 19.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UITextFieldDelegate {
    
    var currentRestaurant: Restaurant?
    
    @IBOutlet var bookingPlaceLabel: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var numberOfPeopleTextField: UITextField!
    @IBOutlet var bookButton: UIButton!
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookButton.addTarget(self, action: #selector(book(sender:)), for: .touchUpInside)
        nameTextField.delegate = self
        dateTextField.delegate = self
        numberOfPeopleTextField.delegate = self
        setupDatePicker()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    // MARK: - Datepicker
    
    func setupDatePicker () {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {}
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(writeDate))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace ,doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
        
    }
    
    @objc func writeDate () {
        getDateFromDatepicker()
        view.endEditing(true)
    }
    
    
    func getDateFromDatepicker () {
        let formater = DateFormatter()
        formater.dateFormat = "E, d MMM HH:mm"
        dateTextField.text = formater.string(from: datePicker.date)
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
