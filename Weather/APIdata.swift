//
//  APIDates.swift
//  Weather
//
//  Created by Teodor Adrian on 7/22/24.
//

let cityFetchURL = "https://api.openweathermap.org/geo/1.0/direct?q="
let cityLimit = "&limit=1"
let appID = "&appid=d47db0c5ab7df0b6ea1d71bfdf6862a8"

let tempFetchURL = "https://api.openweathermap.org/data/2.5/weather?lat="
let lonURL = "&lon="

struct Response: Codable {
    let coord: Coord
    let weather: [WeatherAPI]
    let main: MainAPI
    let name: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct WeatherAPI: Codable {
    let id: Int
    let description: String
}

struct MainAPI: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
}
