//
//  ExcursionsViewController.swift
//  techTest
//
//  Created by David Stothers on 22/06/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import UIKit





class ExcursionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return excursions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        let text = excursions[indexPath.row].name
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedExcursion = indexPath
        excursionName.text = excursions[indexPath.row].name
        let costFlo = (Float(excursions[indexPath.row].cost)/100)
        let costStr = String(format: "%.2f", costFlo)
     
        cost.text = "Approx. " + currency.symbol + costStr
        distanceFromCityCenter.text = String(excursions[indexPath.row].distance) + "m"
        if excursions[indexPath.row].environment.indoors {
            outdoorLabel.text = "Inside or covered activity"
        }
        else
        {
            outdoorLabel.text = "Outside activity"
        }
        
        if excursions[indexPath.row].environment.walking {
            walkingSuitable.text = "Excursion involves lots of walking"
        }
        else
        {
            walkingSuitable.text = "Excursion involves little walking"
        }
        excursionName.isHidden = false
        cost.isHidden = false
        distanceFromCityCenter.isHidden = false
        walkingSuitable.isHidden = false
        outdoorLabel.isHidden = false
        storeSelectedCells()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        excursionName.isHidden = true
        cost.isHidden = true
        distanceFromCityCenter.isHidden = true
        walkingSuitable.isHidden = true
        outdoorLabel.isHidden = true
        
        storeSelectedCells()
    }
    
    func storeSelectedCells() {
        let storedData = tableView.indexPathsForSelectedRows ?? [IndexPath]()
        var storedExcursions = [String]()
        
        for indexPath in storedData {
            storedExcursions.append(excursions[indexPath.row].name)
        }
        let cells = self.tableView.visibleCells
        for cell in cells {
            if cell.isHighlighted {
                storedExcursions.append(cell.textLabel!.text!)
            }
        }
        
        let defaults = UserDefaults.standard
        defaults.set(storedExcursions, forKey: city + "SavedExcursions")
        defaults.synchronize()
    }
    
    var country = ""
    var city = ""
    var currency = Currency(name: "", symbol: "")
    var excursions = [Excursion]()
    var selectedExcursion: IndexPath = []
    
    @IBOutlet weak var excursionName: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var distanceFromCityCenter: UILabel!
    @IBOutlet weak var walkingSuitable: UILabel!
    @IBOutlet weak var outdoorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
       
        let defaults = UserDefaults.standard
        let storedExcursions = defaults.array(forKey: city + "SavedExcursions") ?? [String]()
        let cells = self.tableView.visibleCells
        
        for cell in cells {
            for excursionName in storedExcursions {
                if cell.textLabel!.text == excursionName as? String {
                    cell.isHighlighted = true
                }
            }
        }
        
        
    }
    
    

}
