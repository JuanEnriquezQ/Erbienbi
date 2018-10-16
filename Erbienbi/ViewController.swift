//
//  ViewController.swift
//  Erbienbi
//
//  Created by juan.enriquez on 15/10/18.
//  Copyright © 2018 juan.enriquez. All rights reserved.
//

import UIKit
import CoreLocation
import TwicketSegmentedControl

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, TwicketSegmentedControlDelegate {
    
    //LOCAL VARIABLES------------------------------------
    var popularSpaces = [Space]()
    var localEvents = [Event]()
    var currentCity = ""
    
    //ADD PLACE VIEW LOGIC-------------------------------
    @IBOutlet weak var addPlaceView: UIView!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextfield: UITextField!
    @IBAction func submitButton(_ sender: Any) {
        if cityTextfield.text != "" && nameTextfield.text != "" && nameTextfield.text != "" && priceTextField.text != "" && descriptionTextfield.text != ""{
            let city = cityTextfield.text
            let name = nameTextfield.text
            let price = Double(priceTextField.text!)
            let description = descriptionTextfield.text
            FireLogic.shared.addSpaceToDatabase(name: name!, desc: description!, price: price!, city: city!)
        }
    }
    
    //USER DISPLAY VIEW LOGIC----------------------------
    @IBOutlet weak var userDisplayView: UIView!
    @IBAction func logoutButton(_ sender: Any) {
        //LOGOUT LOGIC CODE
    }
    
    //HOME PAGE VIEW LOGIC-------------------------------
    @IBOutlet weak var localEventsLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let manager = CLLocationManager()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentControl()
        setupCoreLocation()
        loadPopularSpaces()
    }

    func loadPopularSpaces(){
        FireLogic.shared.getPopularSpaces { (spaces, err) in
            self.popularSpaces = spaces
            self.collectionView.reloadData()
        }
    }
    func loadLocalEvents(city: String){
        FireLogic.shared.getEventsAtCurrentLocation(city: city) { (events, error) in
            self.localEvents = events
            self.tableView.reloadData()
        }
    }
    
    func setupCoreLocation() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func setupSegmentControl(){
        let titles = ["Home", "Add", "My Profile"]
        let frame = CGRect(x: 5, y: view.frame.height - 730, width: view.frame.width - 10, height: 20)
        
        let segmentedControl = TwicketSegmentedControl(frame: frame)
        segmentedControl.setSegmentItems(titles)
        segmentedControl.delegate = self
        
        view.addSubview(segmentedControl)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil{
                print("error")
            } else {
                if let place = placemark?[0] {
                    self.currentCity = place.locality!
                    self.loadLocalEvents(city: self.currentCity)
                    self.localEventsLabel.text = place.locality! + " " + "Events"
                }
            }
        }
    }
}
extension ViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularSpaces.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDefault", for: indexPath) as! MainCell
        cell.cityName.text = self.popularSpaces[indexPath.row].name
        cell.descriptionLabel.text = self.popularSpaces[indexPath.row].description
        cell.cityLabel.text = self.popularSpaces[indexPath.row].locationCity
        cell.priceLabel.text = "$" + String(format: "%.2f", self.popularSpaces[indexPath.row].price!)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localEvents.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 119
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! EventTBCell
        cell.eventDateLabel.text = localEvents[indexPath.row].date
        cell.locationLabel.text = localEvents[indexPath.row].locationCity
        cell.nameLabel.text = localEvents[indexPath.row].name
        
        return cell
    }
    func didSelect(_ segmentIndex: Int) {
        switch segmentIndex {
        case 0:
            //SHOW HOME
            userDisplayView.isHidden = true
            addPlaceView.isHidden = true
        case 1:
            //SHOW ADD LOCATION
            userDisplayView.isHidden = true
            addPlaceView.isHidden = false
        case 2:
            //SHOW MY INFO
            userDisplayView.isHidden = false
            addPlaceView.isHidden = true
        default:
            userDisplayView.isHidden = true
        }
        
    }
}

