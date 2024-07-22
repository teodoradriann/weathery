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
    @State private var homeOffset: CGFloat = 0
    @State private var citiesOffset: CGFloat = 0
    @State private var locationOffset: CGFloat = 0
    
    var startColor: Color = Color.blue
    var endColor: Color = Color.yellow
    
    var body: some View {
        ZStack{
            backround
            VStack {
                title
                    .padding(25)
                    .rotationEffect(.degrees(rotationAngle))
                    .onTapGesture {
                        withAnimation(.bouncy(duration: 1.2)) {
                            let randomEffect = Bool.random()
                            if randomEffect == true {
                                rotationAngle -= 360
                            } else {
                                rotationAngle += 360
                            }
                        }
                    }
                WeatherCardView(weather: Weather(city: weather.city, temperature: weather.temperature, conditionID: weather.conditionID))
                Spacer()
                HStack{
                    TextField("City name", text: $cityName)
                        .frame(width: 200)
                        .textFieldStyle(.plain)
                        .padding(15)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .frame(width: 250)
                    searchCity
                }
                Spacer()
                taskBar
            }
        }
    }
    
    var title: some View {
        HStack {
            Text("weathery")
                .font(Font.custom("cute - Personal Use", size: 80))
                .opacity(0.9)
                .foregroundColor(.white)
        }
    }
    
    var searchCity: some View {
        Button {
            if cityName != "" {
                weather.changeCity(newCityName: cityName)
                weather.checkApi()
                cityName = ""
            }
        } label: {
            Image(systemName: "magnifyingglass").colorMultiply(.black)
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
            action()
        } label: {
            VStack {
                Image(systemName: iconName)
                    .foregroundStyle(.white)
                    .font(.title)
                    .offset(y: offset.wrappedValue)
                    .onTapGesture {
                        withAnimation(.bouncy(duration: 0.2)) {
                            offset.wrappedValue = -10
                        }
                        withAnimation(Animation.easeInOut(duration: 0.2).delay(0.2)) {
                            offset.wrappedValue = 0
                        }
                    }
            }
        }
    }
    
    var taskBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 350, height: 60)
                .opacity(0.3)
                .foregroundStyle(.black)
            HStack {
                Spacer()
                createTaskbarButton(iconName: "house.fill", name: "Home", offset: $homeOffset) {
                    
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
        }
    }
}



#Preview {
    WeatherView(weather: WeatherViewModel())
}
