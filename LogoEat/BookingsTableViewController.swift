//
//  BookingsTableViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 16.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class BookingsTableViewController: UITableViewController {
    
    
    
    
    var bookings = [
        Booking(date: "20 May, 19:00", restaurant: Restaurant(name: "Pototski", rating: 9.0, cuisine: "Ukrainian, Italian", description: "Good restaurant for good people.",  location: "Khmel", image: "Pototski")),
        Booking(date: "13 June, 18:30", restaurant: Restaurant(name: "Pototski", rating: 9.0, cuisine: "Ukrainian, Italian", description: "Good restaurant for good people.",  location: "Khmel", image: "Pototski"))
    ]
    
    var sectionsInTable = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sections: NSSet = NSSet(array: sectionsInTable)
        for booking in bookings{
            if !sections.contains(booking.date) {
                sectionsInTable.append(booking.date)
            }
        }
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    func getSectionItems(section: Int) -> [Booking] {
        var sectionItems = [Booking]()
        
        // loop through the testArray to get the items for this sections's date
        for booking in bookings {
            if booking.date == sectionsInTable[section] {
                sectionItems.append(booking)
            }
        }
        
        return sectionItems
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsInTable.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getSectionItems(section: section).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let sectionItems = self.getSectionItems(section: indexPath.section)
        let booking = sectionItems[indexPath.row]
        
        cell.nameLabel.text = booking.restaurant.name
        cell.nameLabel.font = UIFont(name: "OpenSans-SemiBold", size: 18)
        
        cell.ratingLabel.text = String(booking.restaurant.rating)
        switch booking.restaurant.rating {
        case 0..<5:
            cell.ratingLabel.backgroundColor = UIColor(red: 0.878, green: 0.478, blue: 0.373, alpha: 1)
        default:
            cell.ratingLabel.backgroundColor = UIColor(red: 0.239, green: 0.251, blue: 0.357, alpha: 1)
        }
        cell.ratingLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.ratingLabel.layer.cornerRadius = 3
        cell.ratingLabel.layer.masksToBounds = true
        
        cell.cuisineLabel.text = booking.restaurant.cuisine
        
        cell.locationLabel.text = booking.restaurant.location
        
        
        cell.restaurantImage.image = UIImage(named: booking.restaurant.image)
        cell.restaurantImage.layer.cornerRadius = 10
        cell.restaurantImage.clipsToBounds = true
        
        
        cell.mapMarkerImage.image = UIImage(named: "mapMarker")
        cell.mapMarkerImage.clipsToBounds = true
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsInTable[section]
    }
    
    // MARK: - Table view delefate
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {(_,_) in
            let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
            cell.nameLabel.text = "DELETED"
            cell.cuisineLabel.text = "Let's imagine it was deleted"
            cell.locationLabel.text = "Seriously.Deleted."
        })
        
        return [deleteAction]
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let restaurant = bookings[indexPath.row].restaurant
        let newDetailVC = segue.destination as! DetailViewController
        newDetailVC.currentRestaurant = restaurant
    }
    
}
