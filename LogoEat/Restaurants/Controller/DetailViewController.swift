//
//  DetailViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 16.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UITableViewController{
    
    var currentRestaurant: Restaurant?
    
    
    @IBOutlet var restaurantImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var cuisineLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var restaurantMapView: MKMapView!
    @IBOutlet var bookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        setupDetailScreen()
        setupPlacemark()
    }
    
    private func setupDetailScreen() {
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        if currentRestaurant != nil{
            guard let imageName = currentRestaurant?.image else {return}
            restaurantImage.image = UIImage(named: imageName)
            nameLabel.text = currentRestaurant?.name
            
            ratingLabel.text = String(currentRestaurant!.rating)
            switch currentRestaurant!.rating {
            case 0..<5:
                self.ratingLabel.backgroundColor = UIColor(red: 0.878, green: 0.478, blue: 0.373, alpha: 1)
            default:
                self.ratingLabel.backgroundColor = UIColor(red: 0.239, green: 0.251, blue: 0.357, alpha: 1)
            }
            self.ratingLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            self.ratingLabel.layer.cornerRadius = 3
            self.ratingLabel.layer.masksToBounds = true
            
            
            cuisineLabel.text = currentRestaurant?.cuisine
            descriptionLabel.text = currentRestaurant?.description
            locationLabel.text = currentRestaurant?.location
        }
    }
    
    func setupPlacemark(){
        guard let location = currentRestaurant?.location else {
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            
            if let error = error {
                print(error)
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = self.currentRestaurant?.name
            annotation.subtitle = self.currentRestaurant?.cuisine
            
            guard let placemarkLocation = placemark?.location else {return}
            
            annotation.coordinate = placemarkLocation.coordinate
            
            self.restaurantMapView.showAnnotations([annotation], animated: true)
            self.restaurantMapView.selectAnnotation(annotation, animated: true)
        }
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newDetailVC = segue.destination as! BookViewController
        newDetailVC.currentRestaurant = currentRestaurant
    }


}
