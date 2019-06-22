//
//  weatherParser.swift
//  techTest
//
//  Created by David Stothers on 04/06/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import Foundation

public class WeatherParser {
    
    // MARK: - Welcome
    struct Root: Codable {
        let cod: String
        let message: Double
        let cnt: Int
        let list: [sectionWeather]
        let city: City
    }
    
    // MARK: - City
    struct City: Codable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population, timezone: Int
    }
    
    // MARK: - Coord
    struct Coord: Codable {
        let lat, lon: Double
    }
    
    // MARK: - List
    public struct sectionWeather: Codable {
        let dt: Int
        let main: MainClass
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let rain: Rain?
        let sys: Sys
        let dtTxt: String
        
        enum CodingKeys: String, CodingKey {
            case dt, main, weather, clouds, wind, rain, sys
            case dtTxt = "dt_txt"
        }
    }
    
    // MARK: - Clouds
    struct Clouds: Codable {
        let all: Int
    }
    
    // MARK: - MainClass
    struct MainClass: Codable {
        let temp, tempMin, tempMax, pressure: Double
        let seaLevel, grndLevel: Double
        let humidity: Int
        let tempKf: Double
        
        enum CodingKeys: String, CodingKey {
            case temp
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
            case humidity
            case tempKf = "temp_kf"
        }
    }
    
    // MARK: - Rain
    struct Rain: Codable {
        let the3H: Double?
        
        enum CodingKeys: String, CodingKey {
            case the3H = "3h"
        }
    }
    
    // MARK: - Sys
    struct Sys: Codable {
        let pod: Pod
    }
    
    enum Pod: String, Codable {
        case d = "d"
        case n = "n"
    }
    
    // MARK: - Weather
    struct Weather: Codable {
        let id: Int
        let main: MainEnum
        let weatherDescription, icon: String
        
        enum CodingKeys: String, CodingKey {
            case id, main
            case weatherDescription = "description"
            case icon
        }
    }
    
    enum MainEnum: String, Codable {
        case clear = "Clear"
        case clouds = "Clouds"
        case rain = "Rain"
    }
    
    // MARK: - Wind
    struct Wind: Codable {
        let speed, deg: Double
    }
    
    public enum WeatherParser: Error {
        case badJson
    }
    
    
    //Parse the actual json, return a list of establishments. We're ignoring the Meta and links data, though the meta data could be used for security
    public func parseJson(data: Data) throws -> [Int: String]? {
        
        let decoder = JSONDecoder()
        guard let jsonWeather = try? decoder.decode(Root.self, from: data) else {
            print("Error: Couldn't decode data into JsonWeather")
            throw WeatherParser.badJson
        }
        
        var weather = [Int: String]()
        for section in jsonWeather.list {
            weather[section.dt] = section.weather[0].weatherDescription
        }
        return weather
    }
}

