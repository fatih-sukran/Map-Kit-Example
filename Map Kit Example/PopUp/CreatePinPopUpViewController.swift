//
//  CreatePinPopUpViewController.swift
//  Map Kit Example
//
//  Created by fatih.sukran on 18.10.2023.
//

import UIKit
import MapKit

class CreatePinPopUpViewController: UIViewController {

    @IBOutlet weak var locationName: UITextField!
    @IBOutlet weak var locationDescription: UITextField!
    @IBOutlet weak var backView: UIView!
    
    
    private let locationCoreData = CoreDataHelper<Locations>(entitiyName: "Locations")
    private let coordinates: CLLocationCoordinate2D
    
    init(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
        super.init(nibName: "CreatePinPopUpViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        let clickBack = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        backView.addGestureRecognizer(clickBack)
    }
    
    @objc func dismissPopUp() {
        self.dismiss(animated: false)
        self.removeFromParent()
    }
        
    @IBAction func saveLocation(_ sender: UIButton) {
        let location = Locations(context: CoreDataHelper.getManagedObjectContext()!)
        location.id = UUID()
        location.title = locationName.text
        location.subtitle = locationDescription.text
        location.latitude = coordinates.latitude
        location.longitude = coordinates.longitude
        locationCoreData.add(item: location)
        
        dismissPopUp()
    }
}
