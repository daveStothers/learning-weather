//
//  LocationsViewController.swift
//  techTest
//
//  Created by David Stothers on 04/06/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import UIKit

// MARK: - Location
struct Location {
    
    var country: String
    var city: String
    var latitude: Float
    var longitude: Float
    var currency: Currency
    var excursions: [Excursion]
}

struct Currency {
    var name: String
    var symbol: String
}

//Excurions would ideally have other factors, like actual location
struct Excursion {
    var name : String
    var environment: Environment
    //ideally distance is calculated, from a hotel maybe, not stored somewhere
    var distance: Int
    var cost: Int
}

//Environment would ideally have other factors
struct Environment {
    var indoors: Bool
    var walking: Bool
}

var locations = [Location]()

let pound = Currency(name: "Pound Sterling", symbol: "£")

let euro = Currency(name: "Euro", symbol: "€")

let dollar = Currency(name: "US Dollar", symbol: "$")

class LocationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //table view delegate methods.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        let text = locations[indexPath.row].country + ", " + locations[indexPath.row].city
        cell.textLabel?.text = text
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLocation = indexPath
        viewWeatherButton.isHidden = false
        viewExcursions.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewWeatherButton.isHidden = true
        viewExcursions.isHidden = true
    }
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewWeatherButton: UIButton!
    @IBOutlet weak var viewExcursions: UIButton!
    
    var stateShown = "All"
    var result = ""
    var scheme = 1
    var pickResult = ""
    var selectedLocation: IndexPath = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocations()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        view.accessibilityIdentifier = "locationView"
        
        
    }
    
    func setupLocations()
    {
        //Build some fake excursion data, ideally should be retrieved from a jet2 or partners server
        if locations.isEmpty {
            let indoorsNoWalking = Environment(indoors: true, walking: false)
            let outdoorsNoWalking = Environment(indoors: false, walking: false)
            let outdoorsWalking = Environment(indoors: false, walking: true)
            let indoorsWalking = Environment(indoors: true, walking: true)
            
            var berlin = [Excursion]()
            berlin.append(Excursion(name: "Reichstag", environment: indoorsWalking, distance: 1000, cost: 0))
            berlin.append(Excursion(name: "Wintergarten Theatre", environment: indoorsNoWalking, distance: 500, cost: 5000))
            berlin.append(Excursion(name: "Brandenburg Gate", environment: outdoorsWalking, distance: 1000, cost: 0))
            berlin.append(Excursion(name: "Open Air Cinema Holzmarkt25", environment: outdoorsNoWalking, distance: 2000, cost: 0))
            
            var palma = [Excursion]()
            palma.append(Excursion(name: "Palma Aquarium", environment: indoorsWalking, distance: 1000, cost: 3000))
            palma.append(Excursion(name: "Palma City Sightseeing Boat", environment: indoorsNoWalking, distance: 500, cost: 5000))
            palma.append(Excursion(name: "Walking tour", environment: outdoorsWalking, distance: 1000, cost: 1000))
            palma.append(Excursion(name: "Open Topped Bus Tour", environment: outdoorsNoWalking, distance: 2000, cost: 0))
            
            var london = [Excursion]()
            london.append(Excursion(name: "Buckingham Palace", environment: indoorsWalking, distance: 2000, cost: 3000))
            london.append(Excursion(name: "West End Theatre", environment: indoorsNoWalking, distance: 1000, cost: 5000))
            london.append(Excursion(name: "Trafalgar Square", environment: outdoorsWalking, distance: 1000, cost: 0))
            london.append(Excursion(name: "O2 Arena", environment: outdoorsNoWalking, distance: 3000, cost: 5000))
            
            locations.append(Location(country: "Majorca", city: "Palma", latitude: 39.5696, longitude: 2.6502, currency: euro, excursions: palma))
            locations.append(Location(country: "Germany", city: "Berlin", latitude: 52.5200, longitude: 13.4050, currency: euro, excursions: berlin))
            locations.append(Location(country: "UK", city: "London", latitude: 51.5074, longitude: 0.1278, currency: pound, excursions: london))
        }
        
    }
    
    //Override the prepare delegate method to pass data to the subsequent view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? WeatherResultViewController
        {
            vc.city = locations[selectedLocation.row].city
            vc.country = locations[selectedLocation.row].country
            vc.longitude = locations[selectedLocation.row].longitude
            vc.latitude = locations[selectedLocation.row].latitude
            vc.currency = locations[selectedLocation.row].currency
        }
        
        if let vc = segue.destination as? ExcursionsViewController
        {
            vc.city = locations[selectedLocation.row].city
            vc.country = locations[selectedLocation.row].country
            vc.excursions = locations[selectedLocation.row].excursions
            vc.currency = locations[selectedLocation.row].currency
        }
    }
}
