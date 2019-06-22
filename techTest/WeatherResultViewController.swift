//
//  WeatherResultViewController.swift
//  techTest
//
//  Created by David Stothers on 15/06/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import UIKit

class WeatherResultViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //table view delegate methods.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifierB")!
        if weatherList.count > 0 {
            guard let timeDate = Double(weatherList[indexPath.row][0]) else { return cell }
            let textDate = NSDate(timeIntervalSince1970: timeDate)
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date / server String
            formatter.dateFormat = "MM-dd HH:mm"
            let myString = formatter.string(from: textDate as Date) // string purpose I add here
            let text = myString + "      "  + weatherList[indexPath.row][1]
            cell.textLabel?.text = text
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    var country = ""
    var city = ""
    var latitude:Float = 0.0
    var longitude:Float = 0.0
    var weatherSection = [Int:String]()
    var weatherList = [[String]]()
    var currency = Currency(name: "", symbol: "")
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        let location = city + "," + country
        _ = ApiRequests().makeApiRequest(endpoint: location, callback: requestComplete)
    }
    
    func requestComplete(data: Data){
        do {
            try weatherSection = WeatherParser().parseJson(data: data)!
        }
        catch {
            return
        }
        var weatherListOrig = [[String]]()
        for (key,value) in weatherSection {
            weatherListOrig.append([String(key), value])
        }
        weatherList = weatherListOrig.sorted(by: {
            ($0[0],$0[1]) < ($1[0],$1[1])
        })
        updateTableData()
        
    }
    
    func updateTableData() {
        tableView.reloadData()
    }

}
