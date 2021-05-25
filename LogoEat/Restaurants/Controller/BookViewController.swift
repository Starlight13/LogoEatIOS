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
    @IBOutlet var nameError: UILabel!
    @IBOutlet var dateError: UILabel!
    @IBOutlet var numberOfPeopleError: UILabel!
    let datePicker = UIDatePicker()
    
    let nameRegex = "^[a-z а-я A-Z А-Я,.'-]{3,}$"
    let numberOfPeopleRegex = "^([1-9]|1[0-5])$"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookButton.addTarget(self, action: #selector(book(sender:)), for: .touchUpInside)
        nameTextField.delegate = self
        dateTextField.delegate = self
        numberOfPeopleTextField.delegate = self
        setupNumberPad()
        setupDatePicker()
        setupBookScreen()
    }
    
    @objc func book(sender: UIButton){
        if allIsValid() {
            self.dismiss(animated: true, completion: nil)
        } else {
            shake(errorLabel: nameError)
            shake(errorLabel: dateError)
            shake(errorLabel: numberOfPeopleError)
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
    
    func validateDate(datePicker: UIDatePicker, errorLabel: UILabel) -> Bool {
        if (datePicker.date > Calendar.current.date(byAdding: .hour, value: 2, to: Date())!){
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
                return validateDate(datePicker: datePicker, errorLabel: dateError)
            case 2:
                return validate(textField: textField, regex: numberOfPeopleRegex, errorLabel: numberOfPeopleError)
            default:
                return true
            }
        }
        return false
    }
    
    func allIsValid() -> Bool {
        let textFields = [nameTextField, dateTextField, numberOfPeopleTextField]
        for textField in textFields {
            if !validateTextField(textField: textField!) {
                return false
            }
        }
        return true
    }
    
    
    //MARK: - Setup
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
    
    func setupNumberPad(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace ,doneButton], animated: true)
        self.numberOfPeopleTextField.inputAccessoryView = toolbar
    }
    
    @objc func done() {
        _ = validateTextField(textField: numberOfPeopleTextField)
        numberOfPeopleTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = validateTextField(textField: textField)
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
        _ = validateTextField(textField: dateTextField)
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

extension String {
    func matches(_ regex: String) -> Bool {
        return (self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil)
    }
}
