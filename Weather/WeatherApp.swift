//
//  WeatherApp.swift
//  Weather
//
//  Created by Teodor Adrian on 7/21/24.
//

import Foundation

let cityFetchURL = "https://api.openweathermap.org/geo/1.0/direct?q="
let cityLimit = "&limit=1"
let appID = "&appid=d47db0c5ab7df0b6ea1d71bfdf6862a8"

struct Weather {
    private var city: String?
    private var temperature: Double?
    private var conditionID: Int?
    private var coords: Coords?
    
    var temperatureString: String {
        if let temperatureGood = temperature {
            return String(format: "%.1f", temperatureGood)
        } else {
            return ""
        }
    }
    
    var conditionName: String {
        if let conditionIDGood = conditionID {
            switch conditionIDGood {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
            }
        } else {
            return ""
        }
    }
    
    // function which sets the city name
    mutating func setCity(cityName: String) {
        city = cityName
    }
    
    struct Coords: Decodable {
        var lat: Double
        var lon: Double
    }
    
    mutating func updateCoords(lat: Double, lon: Double) {
        if coords == nil {
            coords = Coords(lat: lat, lon: lon)
        } else {
            coords?.lat = lat
            coords?.lon = lon
        }
    }
    
    // marking the function as mutating because i'm updating the coords
    mutating func fetchCity() {
        let urlToFetch: String
        
        // build the URL to call
        if let cityGood = city {
            urlToFetch = cityFetchURL + cityGood + cityLimit + appID
        } else {
            return
        }
        
        // declaring the URL
        guard let url = URL(string: urlToFetch) else {
            return
        }
        
        // declaring the request and request type
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // init the session
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [self] data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            // decoding the data from JSON and updating the coords
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let cityCoords = try decoder.decode([Coords].self, from: data)
                    if let firstCoords = cityCoords.first {
                        DispatchQueue.main.async {
                            var mutableSelf = self
                            mutableSelf.updateCoords(lat: firstCoords.lat, lon: firstCoords.lon)
                            print("Latitude: \(firstCoords.lat), Longitude: \(firstCoords.lon)")
                        }
                    } else {
                        print("No coordinates found.")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
