//
//  WeatherApp.swift
//  Weather
//
//  Created by Teodor Adrian on 7/21/24.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject var weatherApp = WeatherViewModel()
    var body: some Scene {
        WindowGroup {
            WeatherView(weather: weatherApp)
        }
    }
}
