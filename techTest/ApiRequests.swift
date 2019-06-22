//
//  ApiRequests.swift
//  techTest
//
//

import Foundation

class ApiRequests {

    var session = URLSession.shared

    //Perform an actual api request
    public func makeApiRequest(endpoint: String, callback:  @escaping (_ data: Data) -> Void) -> String {
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast?q=" + endpoint + "&APPID=5743a3260d73974404fd3b73b822c38d")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            guard error == nil else {
                return
            }
            guard let data = data else { return }
            do{
                DispatchQueue.main.async {
                    callback(data)
                }
            }
        }
        task.resume()
        return "Loading"
    }

}
