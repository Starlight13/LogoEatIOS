//
//  MapViewController.swift
//  LogoEat
//
//  Created by dsadas asdasd on 22.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var currentRestaurant: Restaurant?
    let annotationIdentifier = "annotationIdentifier"
    let locationManager = CLLocationManager()
    let regionMeters = 10000.00

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var userLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        setupUserLocationButton()
        setupPlacemark()
        checkLocationServices()
    }
    
    func setupUserLocationButton() {
        userLocationButton.addTarget(self, action: #selector(centerToUserLocation), for: .touchUpInside)
        userLocationButton.layer.cornerRadius = 5
        userLocationButton.layer.shadowColor = UIColor.black.cgColor
        userLocationButton.layer.shadowOpacity = 0.3
        userLocationButton.layer.shadowOffset = .zero
        userLocationButton.layer.shadowRadius = 3
        userLocationButton.layer.shadowPath = UIBezierPath(rect: userLocationButton.bounds).cgPath
        userLocationButton.layer.shouldRasterize = true
        userLocationButton.layer.rasterizationScale = UIScreen.main.scale
    }
    
    @objc func centerToUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
            mapView.setRegion(region, animated: true)
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
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    private func checkLocationServices() {
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.showAlert(title: "Location services are disabled", message: "To use this feature turn on location services in: Settings -> Privacy -> Location services")
            }
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            break
        case .denied:
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.showAlert(title: "Location services are denied for this app", message: "To use this feature turn on location services for this app in: Settings -> Privacy -> Location services")
            }
        break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.showAlert(title: "Location services are restricted for this app", message: "To use this feature turn on location services for this app in: Settings -> Privacy -> Location services")
            }
            break
        case .authorizedAlways:
            break
        }
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}

//MARK: - Extensions

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
        }
        if let imageData = currentRestaurant?.image {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.image = UIImage(data: imageData)
            annotationView?.rightCalloutAccessoryView = imageView
        }
        return annotationView
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
