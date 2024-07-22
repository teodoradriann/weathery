import SwiftUI
import Foundation

class WeatherViewModel: ObservableObject {
    @Published private var weather = Weather()
    
    func checkApi() {
        weather.fetchCity { [weak self] updatedWeather in
            DispatchQueue.main.async {
                self?.weather = updatedWeather
                
                // Now fetch weather details based on the updated city
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
        return weather.city ?? "UNKNOWN"
    }
    
    var temperature: Double {
        return weather.temperature ?? 0.0
    }
    
    var conditionID: Int {
        return weather.conditionID ?? 0
    }
}
