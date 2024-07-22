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
}
