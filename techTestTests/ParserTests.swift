//
//  techTestTests.swift
//  techTestTests
//
//  Created by David Stothers on 25/05/2019.
//  Tests all JSON parsing and data handling methods. Networking tests have not been included although I did make a start on them for the sake of getting the project finished.
//

import XCTest
@testable import techTest

class techTestTests: XCTestCase {
    func testWeatherParserProcessesNormalJSONCorrectly() {
        let testJson: Data? = """
        {
            "cod": "200",
            "message": 0.0083,
            "cnt": 40,
            "list": [
                {
                    "dt": 1561226400,
                    "main": {
                        "temp": 294.01,
                        "temp_min": 294.01,
                        "temp_max": 295.091,
                        "pressure": 1017.46,
                        "sea_level": 1017.46,
                        "grnd_level": 980.97,
                        "humidity": 84,
                        "temp_kf": -1.08
                    },
                    "weather": [
                        {
                            "id": 500,
                            "main": "Rain",
                            "description": "light rain",
                            "icon": "10d"
                        }
                    ],
                    "clouds": {
                        "all": 88
                    },
                    "wind": {
                        "speed": 2.66,
                        "deg": 278.523
                    },
                    "rain": {
                        "3h": 2.063
                    },
                    "sys": {
                        "pod": "d"
                    },
                    "dt_txt": "2019-06-22 18:00:00"
                },
                {
                    "dt": 1561237200,
                    "main": {
                        "temp": 299,
                        "temp_min": 299,
                        "temp_max": 299.803,
                        "pressure": 1016.22,
                        "sea_level": 1016.22,
                        "grnd_level": 980.04,
                        "humidity": 63,
                        "temp_kf": -0.81
                    },
                    "weather": [
                        {
                            "id": 804,
                            "main": "Clouds",
                            "description": "overcast clouds",
                            "icon": "04d"
                        }
                    ],
                    "clouds": {
                        "all": 100
                    },
                    "wind": {
                        "speed": 1.39,
                        "deg": 305.682
                    },
                    "sys": {
                        "pod": "d"
                    },
                    "dt_txt": "2019-06-22 21:00:00"
                }
            ],
            "city": {
                "id": 4298960,
                "name": "London",
                "coord": {
                    "lat": 37.129,
                    "lon": -84.0833
                },
                "country": "US",
                "population": 7993,
                "timezone": -14400
            }
        }
        """.data(using: .utf8)
        var weather = [Int: String]()
        do {
            weather = try WeatherParser().parseJson(data: testJson!)!
        }
        catch {
            XCTFail()
        }
      
        XCTAssertEqual(weather.count, 2)
    }
    
    func testWeatherParserThrowsOnMalformedJSON() {
        // test misnamed parameter (message, instead of massage)
        let testJson: Data? = """
         {
            "cod": "200",
            "massage": 0.0083,
            "cnt": 40,
            "list": [
                {
                    "dt": 1561226400,
                    "main": {
                        "temp": 294.01,
                        "temp_min": 294.01,
                        "temp_max": 295.091,
                        "pressure": 1017.46,
                        "sea_level": 1017.46,
                        "grnd_level": 980.97,
                        "humidity": 84,
                        "temp_kf": -1.08
                    },
                    "weather": [
                        {
                            "id": 500,
                            "main": "Rain",
                            "description": "light rain",
                            "icon": "10d"
                        }
                    ],
                    "clouds": {
                        "all": 88
                    },
                    "wind": {
                        "speed": 2.66,
                        "deg": 278.523
                    },
                    "rain": {
                        "3h": 2.063
                    },
                    "sys": {
                        "pod": "d"
                    },
                    "dt_txt": "2019-06-22 18:00:00"
                },
                {
                    "dt": 1561237200,
                    "main": {
                        "temp": 299,
                        "temp_min": 299,
                        "temp_max": 299.803,
                        "pressure": 1016.22,
                        "sea_level": 1016.22,
                        "grnd_level": 980.04,
                        "humidity": 63,
                        "temp_kf": -0.81
                    },
                    "weather": [
                        {
                            "id": 804,
                            "main": "Clouds",
                            "description": "overcast clouds",
                            "icon": "04d"
                        }
                    ],
                    "clouds": {
                        "all": 100
                    },
                    "wind": {
                        "speed": 1.39,
                        "deg": 305.682
                    },
                    "sys": {
                        "pod": "d"
                    },
                    "dt_txt": "2019-06-22 21:00:00"
                }
            ],
            "city": {
                "id": 4298960,
                "name": "London",
                "coord": {
                    "lat": 37.129,
                    "lon": -84.0833
                },
                "country": "US",
                "population": 7993,
                "timezone": -14400
            }
        }
        """.data(using: .utf8)
        var weather = [Int: String]()
        do {
            weather = try WeatherParser().parseJson(data: testJson!)!
        }
        catch {
            XCTAssertTrue(weather.isEmpty)
        }
        XCTAssertTrue(weather.isEmpty)
        
        //Test missing timestamp
        let testJson2: Data? = """
         {
            "cod": "200",
            "message": 0.0083,
            "cnt": 40,
            "list": [
                {
                    "main": {
                        "temp": 294.01,
                        "temp_min": 294.01,
                        "temp_max": 295.091,
                        "pressure": 1017.46,
                        "sea_level": 1017.46,
                        "grnd_level": 980.97,
                        "humidity": 84,
                        "temp_kf": -1.08
                    },
                    "weather": [
                        {
                            "id": 500,
                            "main": "Rain",
                            "description": "light rain",
                            "icon": "10d"
                        }
                    ],
                    "clouds": {
                        "all": 88
                    },
                    "wind": {
                        "speed": 2.66,
                        "deg": 278.523
                    },
                    "rain": {
                        "3h": 2.063
                    },
                    "sys": {
                        "pod": "d"
                    },
                    "dt_txt": "2019-06-22 18:00:00"
                },
                {
                    "dt": 1561237200,
                    "main": {
                        "temp": 299,
                        "temp_min": 299,
                        "temp_max": 299.803,
                        "pressure": 1016.22,
                        "sea_level": 1016.22,
                        "grnd_level": 980.04,
                        "humidity": 63,
                        "temp_kf": -0.81
                    },
                    "weather": [
                        {
                            "id": 804,
                            "main": "Clouds",
                            "description": "overcast clouds",
                            "icon": "04d"
                        }
                    ],
                    "clouds": {
                        "all": 100
                    },
                    "wind": {
                        "speed": 1.39,
                        "deg": 305.682
                    },
                    "sys": {
                        "pod": "d"
                    },
                    "dt_txt": "2019-06-22 21:00:00"
                }
            ],
            "city": {
                "id": 4298960,
                "name": "London",
                "coord": {
                    "lat": 37.129,
                    "lon": -84.0833
                },
                "country": "US",
                "population": 7993,
                "timezone": -14400
            }
        }
        """.data(using: .utf8)
        var weather2 = [Int: String]()
        do {
            weather2 = try WeatherParser().parseJson(data: testJson2!)!
        }
        catch {
            XCTAssertTrue(weather2.isEmpty)
        }
        XCTAssertTrue(weather2.isEmpty)
        
        //Test wrong type for cod
        let testJson3: Data? = """
        {
            "cod": 200,
            "message": 0.0083,
            "cnt": 40,
            "list": [
                {
                    "dt": 1561226400,
                    "main": {
                        "temp": 294.01,
                        "temp_min": 294.01,
                        "temp_max": 295.091,
                        "pressure": 1017.46,
                        "sea_level": 1017.46,
                        "grnd_level": 980.97,
                        "humidity": 84,
                        "temp_kf": -1.08
                    },
                    "weather": [
                        {
                            "id": 500,
                            "main": "Rain",
                            "description": "light rain",
                            "icon": "10d"
                        }
                    ],
                    "clouds": {
                        "all": 88
                    },
                    "wind": {
                        "speed": 2.66,
                        "deg": 278.523
                    },
                    "rain": {
                        "3h": 2.063
                    },
                    "sys": {
                        "pod": "d"
                    },
                    "dt_txt": "2019-06-22 18:00:00"
                },
                {
                    "dt": 1561237200,
                    "main": {
                        "temp": 299,
                        "temp_min": 299,
                        "temp_max": 299.803,
                        "pressure": 1016.22,
                        "sea_level": 1016.22,
                        "grnd_level": 980.04,
                        "humidity": 63,
                        "temp_kf": -0.81
                    },
                    "weather": [
                        {
                            "id": 804,
                            "main": "Clouds",
                            "description": "overcast clouds",
                            "icon": "04d"
                        }
                    ],
                    "clouds": {
                        "all": 100
                    },
                    "wind": {
                        "speed": 1.39,
                        "deg": 305.682
                    },
                    "sys": {
                        "pod": "d"
                    },
                    "dt_txt": "2019-06-22 21:00:00"
                }
            ],
            "city": {
                "id": 4298960,
                "name": "London",
                "coord": {
                    "lat": 37.129,
                    "lon": -84.0833
                },
                "country": "US",
                "population": 7993,
                "timezone": -14400
            }
        }
        """.data(using: .utf8)
        var authorities3 = [Int: String]()
        do {
            authorities3 = try WeatherParser().parseJson(data: testJson3!)!
        }
        catch {
            XCTAssertTrue(authorities3.isEmpty)
        }
    }
    
    func testAuthoritiesParserThrowsOnEmptyJSON() {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testJson: Data? = """
        {
           
        }
        """.data(using: .utf8)
        var weather = [Int: String]()
        do {
            weather = try WeatherParser().parseJson(data: testJson!)!
        }
        catch {
            XCTAssertTrue(weather.isEmpty)
        }
        XCTAssertTrue(weather.isEmpty)
    }

    func testPerformanceAuthorities() {
        // Testing timeing of parsing
        self.measure {
            let testJson: Data? = """
            {
                "cod": "200",
                "message": 0.0083,
                "cnt": 40,
                "list": [
                    {
                        "dt": 1561226400,
                        "main": {
                            "temp": 294.01,
                            "temp_min": 294.01,
                            "temp_max": 295.091,
                            "pressure": 1017.46,
                            "sea_level": 1017.46,
                            "grnd_level": 980.97,
                            "humidity": 84,
                            "temp_kf": -1.08
                        },
                        "weather": [
                            {
                                "id": 500,
                                "main": "Rain",
                                "description": "light rain",
                                "icon": "10d"
                            }
                        ],
                        "clouds": {
                            "all": 88
                        },
                        "wind": {
                            "speed": 2.66,
                            "deg": 278.523
                        },
                        "rain": {
                            "3h": 2.063
                        },
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2019-06-22 18:00:00"
                    },
                    {
                        "dt": 1561237200,
                        "main": {
                            "temp": 299,
                            "temp_min": 299,
                            "temp_max": 299.803,
                            "pressure": 1016.22,
                            "sea_level": 1016.22,
                            "grnd_level": 980.04,
                            "humidity": 63,
                            "temp_kf": -0.81
                        },
                        "weather": [
                            {
                                "id": 804,
                                "main": "Clouds",
                                "description": "overcast clouds",
                                "icon": "04d"
                            }
                        ],
                        "clouds": {
                            "all": 100
                        },
                        "wind": {
                            "speed": 1.39,
                            "deg": 305.682
                        },
                        "sys": {
                            "pod": "d"
                        },
                        "dt_txt": "2019-06-22 21:00:00"
                    }
                ],
                "city": {
                    "id": 4298960,
                    "name": "London",
                    "coord": {
                        "lat": 37.129,
                        "lon": -84.0833
                    },
                    "country": "US",
                    "population": 7993,
                    "timezone": -14400
                }
            }
            """.data(using: .utf8)
            do {
                _ = try WeatherParser().parseJson(data: testJson!)!
            }
            catch {
                XCTFail()
            }
            
            
        }
    }
    
}
