//
//  WeatherApp.swift
//  Weather
//
//  Created by Teodor Adrian on 7/21/24.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(weather: WeatherViewModel())
        }
    }
}
