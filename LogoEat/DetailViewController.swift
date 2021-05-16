//
//  DetailViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 16.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController{
    
    var currentRestaurant: Restaurant?
    
    
    @IBOutlet var restaurantImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cuisineLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var restaurantMapView: MKMapView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var bookButton: UIButton!
    @IBOutlet var mapMarkerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailScreen()
    }
    
    private func setupDetailScreen() {
        if currentRestaurant != nil{
            guard let imageName = currentRestaurant?.image else {return}
            restaurantImage.image = UIImage(named: imageName)
            mapMarkerImage.image = UIImage(named: "mapMarker")
            nameLabel.text = currentRestaurant?.name
            cuisineLabel.text = currentRestaurant?.cuisine
            descriptionLabel.text = currentRestaurant?.description
            locationLabel.text = currentRestaurant?.location
        }
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
