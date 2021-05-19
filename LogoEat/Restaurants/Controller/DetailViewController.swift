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
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        setupDetailScreen()
        setupPlacemark()
    }
    
    override func viewWillLayoutSubviews(){
    super.viewWillLayoutSubviews()
    scrollView.contentSize = CGSize(width: 414, height: 920)
        scrollView.frame.size = CGSize(width: 400, height: 900)

    }
    
    private func setupDetailScreen() {
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        if currentRestaurant != nil{
            guard let imageName = currentRestaurant?.image else {return}
            restaurantImage.image = UIImage(named: imageName)
            nameLabel.text = currentRestaurant?.name
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
