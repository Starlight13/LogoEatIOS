//
//  LikedTableViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 22.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class LikedTableViewController: UITableViewController {

    var likedRestaurants:[Restaurant] = []
    
    
    override func viewDidLoad() {
        tableView.backgroundColor = UIColor(red: 0.335, green: 0.35, blue: 0.488, alpha: 1)
        super.viewDidLoad()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return likedRestaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantTableViewCell
        
        let restaurant = likedRestaurants[indexPath.row]
        
        cell.configure(with: restaurant)
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {(_,_) in
            self.likedRestaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        
        return [deleteAction]
    }


    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let indexPath = tableView.indexPathForSelectedRow else {return}
         let restaurant = likedRestaurants[indexPath.row]
         let newDetailVC = segue.destination as! DetailViewController
         newDetailVC.currentRestaurant = restaurant
     }


}
