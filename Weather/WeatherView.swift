//
//  ContentView.swift
//  Weather
//
//  Created by Teodor Adrian on 7/21/24.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var weather: WeatherViewModel
    
    @State private var cityName = ""
    @State private var animatedGardient: Bool = false
    @State private var rotationAngle: Double = 0
    @State private var searchScale: Double = 1.5
    @State private var homeOffset: CGFloat = 0
    @State private var citiesOffset: CGFloat = 0
    @State private var locationOffset: CGFloat = 0
    @FocusState private var textBarFocused: Bool
    @State private var pressedSearch: Bool = false
    
    var startColor: Color = Color.blue
    var endColor: Color = Color.yellow
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            backround
            VStack {
                title
                WeatherCardView(weather: Weather(city: weather.city, temperature: weather.temperature, conditionID: weather.conditionID, description: weather.description, realFeel: weather.realFeel))
                Spacer()
                HStack {
                    searchField
                    searchCity
                }
                Spacer()
                taskBar
            }
            .environment(\.colorScheme, .light)
        }
    }
    
    var searchField: some View {
        TextField("City Name", text: $cityName)
            .frame(width: 200)
            .textFieldStyle(.plain)
            .padding(15)
            .background(Color.white.opacity(0.8))
            .cornerRadius(20)
            .frame(width: 250)
            .focused($textBarFocused)
            .environment(\.colorScheme, .light)
    }
    
    var title: some View {
        HStack {
            Text("Weathery")
                .font(Font.custom("cute - Personal Use", size: 80))
                .opacity(0.9)
                .foregroundColor(.white)
                .padding(25)
                .rotationEffect(.degrees(rotationAngle))
                .onTapGesture {
                    withAnimation(.bouncy(duration: 2)) {
                        let randomEffect = Bool.random()
                        if randomEffect == true {
                            rotationAngle -= 360
                        } else {
                            rotationAngle += 360
                        }
                    }
                }
        }
    }
    
    var searchCity: some View {
           Button {
               withAnimation(.bouncy(duration: 0.2)) {
                   searchScale = 1.0
               }
               withAnimation(Animation.easeInOut(duration: 0.2).delay(0.2)) {
                   searchScale = 1.5
               }
               if cityName != "" {
                   weather.changeCity(newCityName: cityName)
                   weather.checkApi()
                   cityName = ""
                   textBarFocused = false
               }
           } label: {
               Image(systemName: "magnifyingglass")
                   .foregroundStyle(.white)
                   .scaleEffect(searchScale)
           }
       }
    
    var backround: some View {
        LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            .hueRotation(.degrees(animatedGardient ? 45 : 0))
            .onAppear {
                withAnimation(.easeInOut(duration: 3)
                    .repeatForever(autoreverses: true)){
                        animatedGardient.toggle()
                    }
            }
    }
    
    func createTaskbarButton(iconName: String, name: String, offset: Binding<CGFloat>, action: @escaping () -> Void) -> some View {
        return Button {
            withAnimation(.bouncy(duration: 0.2)) {
                offset.wrappedValue = -10
            }
            withAnimation(Animation.easeInOut(duration: 0.2).delay(0.2)) {
                offset.wrappedValue = 0
            }
            action()
        } label: {
            VStack {
                Image(systemName: iconName)
                    .foregroundStyle(.white)
                    .font(.title)
                    .offset(y: offset.wrappedValue)
            }
        }
    }
    
    var taskBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 350, height: 60)
                .opacity(0.1)
            HStack {
                Spacer()
                createTaskbarButton(iconName: "house.fill", name: "Home", offset: $homeOffset) {
                    weather.coords()
                }
                Spacer()
                createTaskbarButton(iconName: "map.fill", name: "My Cities", offset: $citiesOffset) {
                    
                }
                Spacer()
                createTaskbarButton(iconName: "paperplane.fill", name: "My Location", offset: $locationOffset) {
                    
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .opacity(0.8)
            .ignoresSafeArea(.keyboard)
        }
    }
}



#Preview {
    WeatherView(weather: WeatherViewModel())
}
