//
//  MapViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 22.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var currentRestaurant: Restaurant?
    

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        setupPlacemark()
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
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
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
