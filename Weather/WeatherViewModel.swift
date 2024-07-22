import SwiftUI
import Foundation

class WeatherViewModel: ObservableObject {
    @Published private var weather = Weather()
    
    func checkApi() {
        weather.fetchCity { [weak self] updatedWeather in
            DispatchQueue.main.async {
                self?.weather = updatedWeather
                
                // fetch weather details based on the updated city
                self?.weather.fetchWeather { [weak self] updatedWeather in
                    DispatchQueue.main.async {
                        self?.weather = updatedWeather
                    }
                }
            }
        }
    }
    
    // MARK: functions
    
    func changeCity(newCityName: String) {
        weather.setCity(cityName: newCityName)
    }
    
    func coords() {
        weather.printCoords()
    }
    
    // MARK: variables
    
    var city: String {
        weather.city ?? "UNKNOWN"
    }
    
    var temperature: Double {
        weather.temperature ?? 0
    }
    
    var realFeel: Double {
        weather.realFeel ?? 0
    }
    
    var conditionID: Int {
        weather.conditionID ?? 0
    }
    
    var description: String {
        weather.description ?? "UNKNOWN"
    }
}

