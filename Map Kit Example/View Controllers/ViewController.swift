//
//  ViewController.swift
//  Map Kit Example
//
//  Created by fatih.sukran on 24.09.2023.
//

import UIKit
import MapKit
import CoreData
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationName: UITextField!
    @IBOutlet weak var locationDescription: UITextField!
    
    var location: Locations?
    private var locationManager = CLLocationManager()
    private var locationCoreData = CoreDataHelper<Locations>(entitiyName: "Locations")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // add long press gesture recognizer
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        
        mapView.addGestureRecognizer(gestureRecognizer)
        if let location = location {
            addAnnotation(latitude: location.latitude, longitude: location.longitude,
                          title: location.title, subtitle: location.subtitle)
        }
    }
    
    func determineLocation() {
        if location != nil {
            let coordinate = CLLocationCoordinate2D(latitude: location?.latitude, longitude: location.)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // updated location
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        // zoom level
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: self.mapView)
            let coordinates = mapView.convert(point, toCoordinateFrom: self.mapView)
            addAnnotation(latitude: coordinates.latitude, longitude: coordinates.longitude, 
                          title: locationName.text, subtitle: locationDescription.text)
            
            let location = Locations(context: CoreDataHelper.getManagedObjectContext()!)
            location.id = UUID()
            location.title = locationName.text
            location.subtitle = locationDescription.text
            location.latitude = coordinates.latitude
            location.longitude = coordinates.longitude
            locationCoreData.add(item: location)
        }
    }
    
    func addAnnotation(latitude: Double, longitude: Double, title: String?, subtitle: String? = nil) {
        let annotion = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        annotion.coordinate = coordinate
        annotion.title = title
        annotion.subtitle = subtitle
        mapView.addAnnotation(annotion)
    }
}

