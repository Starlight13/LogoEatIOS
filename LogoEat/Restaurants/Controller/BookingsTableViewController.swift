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
        tableView.backgroundColor = UIColor(red: 0.335, green: 0.35, blue: 0.488, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.239, green: 0.251, blue: 0.357, alpha: 1)
        for booking in bookings{
            sectionsInTable.append(booking.date)
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = .white
        (view as? UITableViewHeaderFooterView)?.textLabel?.font = UIFont(name: "Helvetica Neue", size: 24)
        (view as? UITableViewHeaderFooterView)?.tintColor = .clear
    }
    
    // MARK: - Table view data source
    func getSectionItems(section: Int) -> [Booking] {
        var sectionItems = [Booking]()
        
        // loop through the testArray to get the items for this sections's date
        sectionItems.append(bookings[section])
        
        return sectionItems
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsInTable.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getSectionItems(section: section).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantTableViewCell
        
        let sectionItems = self.getSectionItems(section: indexPath.section)
        let booking = sectionItems[indexPath.row]
        
        cell.configure(with: booking.restaurant)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsInTable[section]
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {(_,_) in
            self.bookings.remove(at: indexPath.section)
            self.sectionsInTable.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .automatic)
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
