//
//  WeatherApp.swift
//  Weather
//
//  Created by Teodor Adrian on 7/21/24.
//

import Foundation
import SwiftUI

struct Weather {
    private(set) var city: String?
    private(set) var temperature: Double?
    private(set) var conditionID: Int?
    private(set) var coords: Coords?
    
    var temperatureString: String {
        if let temperature = temperature {
            return String(format: "%.1f", temperature)
        } else {
            return "UNKNOWN"
        }
    }
    
    var conditionName: String {
        if let conditionID = conditionID {
            switch conditionID {
            case 0:
                return "questionmark"
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
            return "UNKNOWN"
        }
    }
    
    var conditionColor: Color {
        if let conditionID = conditionID {
            switch conditionID {
            case 0:
                return Color.white
            case 200...232:
                return Color.cyan
            case 300...321:
                return Color.teal
            case 500...531:
                return Color.blue
            case 600...622:
                return Color.white
            case 701...781:
                return Color.gray
            case 800:
                return Color.yellow
            case 801...804:
                return Color.orange
            default:
                return Color.cyan
            }
        } else {
            return Color.white
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
        if let city = city {
            urlToFetch = cityFetchURL + city + cityLimit + appID
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
    
    func convertToString(_ value1: Double, _ value2: Double) -> (String, String) {
        let string1 = "\(value1)"
        let string2 = "\(value2)"
        return (string1, string2)
    }
    
    mutating func fetchWeather() {
        let urlToFetch: String
        
        if let city = city {
            if let latCoord = coords?.lat, let lonCoord = coords?.lon {
                let (lat, lon) = convertToString(latCoord, lonCoord)
                
                urlToFetch =  tempFetchURL + lat + lonURL + lon + appID
                
                guard let url = URL(string: urlToFetch) else {
                    return
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                let session = URLSession.shared
                //let task =
                
                
            }
        } else {
            return
        }
        
    }
}
