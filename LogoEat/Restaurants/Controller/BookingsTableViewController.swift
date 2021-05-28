//
//  BookingsTableViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 16.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit
import RealmSwift


class BookingsTableViewController: UITableViewController {
    
    var bookings: Results<Booking>!
    var sectionsInTable = [Date]()
    var notificationToken: NotificationToken? = nil
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @objc func refresh(sender: UIRefreshControl) {
        sender.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = myRefreshControl
        
        bookings = realm.objects(Booking.self)
        
        tableView.backgroundColor = UIColor(red: 0.335, green: 0.35, blue: 0.488, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.239, green: 0.251, blue: 0.357, alpha: 1)
        tabBarController?.tabBar.barTintColor = UIColor(red: 0.239, green: 0.251, blue: 0.357, alpha: 1)
        
        if !bookings.isEmpty{
            for booking in bookings{
                sectionsInTable.append(booking.date)
            }
        }
        self.tableView.reloadData()
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = .white
        (view as? UITableViewHeaderFooterView)?.textLabel?.font = UIFont(name: "Helvetica Neue", size: 24)
        (view as? UITableViewHeaderFooterView)?.tintColor = .clear
    }
    
    // MARK: - Table view data source
    func getSectionItems(section: Int) -> [Booking] {
        var sectionItems = [Booking]()
        if !bookings.isEmpty{
        sectionItems.append(bookings[section])
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantTableViewCell

        let sectionItems = self.getSectionItems(section: indexPath.section)
        let booking = sectionItems[indexPath.row]

        cell.configure(with: booking.restaurant!)


        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM HH:mm"
        return formatter.string(from: sectionsInTable[section])
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let booking = self.bookings[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {(_,_) in
            LocalStorageManager.deleteObject(booking)
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
