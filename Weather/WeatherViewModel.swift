//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Teodor Adrian on 7/21/24.
//

import SwiftUI
import Foundation

class WeatherViewModel: ObservableObject {
    @Published private var weather = Weather()
    
    func checkApi(){
        weather.fetchCity()
    }
    
    func changeCity(newCityName: String) {
        weather.setCity(cityName: newCityName)
    }
    
    var city: String {
        if let city = weather.city {
            return city
        } else {
            return "UNKNOWN"
        }
    }
    
    var temperature: Double {
        if let temperature = weather.temperature {
            return temperature
        } else {
            return 0.0
        }
    }
    
    var conditionID: Int {
        if let conditionID = weather.conditionID {
            return conditionID
        } else {
            return 0
        }
    }
}
