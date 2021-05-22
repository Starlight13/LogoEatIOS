//
//  TableView_RestaurantsTableViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 16.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit

class RestaurantsTableViewController: UITableViewController {
    
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private var filteredRestaurants = [Restaurant]()
    private let restaurants = [
        Restaurant(name: "Pototski", rating: 9.0, cuisine: "Ukrainian, Italian", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque commodo velit ut quam ullamcorper porttitor.", location: "Khmelnystsky, Proskurivska, 45", image: "Pototski"),
        Restaurant(name: "Shpigel", rating: 4.5, cuisine: "Israel", description: "Good restaurant for good people.", location: "Khmelnystsky", image: "Pototski"),
        Restaurant(name: "Craft", rating: 8.8, cuisine: "American, European", description: "Good restaurant for good people.",  location: "Khmelnystsky", image: "Pototski")
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 0.335, green: 0.35, blue: 0.488, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.239, green: 0.251, blue: 0.357, alpha: 1)
        tabBarController?.tabBar.barTintColor = UIColor(red: 0.239, green: 0.251, blue: 0.357, alpha: 1)
        
        // Search controller setup
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search restaurant"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering == true {
            return filteredRestaurants.count
        }
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantTableViewCell
        
        var restaurant = Restaurant(name: "", rating: 0, cuisine: "", description: "", location: "", image: "")
        
        if isFiltering {
            restaurant = filteredRestaurants[indexPath.row]
        } else {
            restaurant = restaurants[indexPath.row]
        }
        
        cell.configure(with: restaurant)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        var restaurant = Restaurant(name: "", rating: 0, cuisine: "", description: "", location: "", image: "")
        if isFiltering == true {
            restaurant = filteredRestaurants[indexPath.row]
        } else {
            restaurant = restaurants[indexPath.row]
        }
        let newDetailVC = segue.destination as! DetailViewController
        newDetailVC.currentRestaurant = restaurant
    }
    
    
}

extension RestaurantsTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText (_ searchText: String){
        filteredRestaurants = restaurants.filter{ $0.name.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
    
}
