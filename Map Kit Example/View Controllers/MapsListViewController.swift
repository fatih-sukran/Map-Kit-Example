//
//  MapsListViewController.swift
//  Map Kit Example
//
//  Created by fatih.sukran on 27.09.2023.
//

import UIKit

class MapsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    private var locations: [Locations] = []
    private var selectedIndex: Int?
    private let coreDataHelper = CoreDataHelper<Locations>(entitiyName: "Locations")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        locations = coreDataHelper.getAll()
        tableView.reloadData()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(clickAddButton))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = addButton
    }
    
    @objc func clickAddButton() {
        selectedIndex = nil
        performSegue(withIdentifier: Constants.mapPageSegue, sender: nil)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = locations[indexPath.row].title
        content.secondaryText = locations[indexPath.row].subtitle
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: Constants.mapPageSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = selectedIndex {
            let viewController = segue.destination as? ViewController
            viewController?.location = locations[index]
        }
    }
    

}
