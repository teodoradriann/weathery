//
//  ContentView.swift
//  Weather
//
//  Created by Teodor Adrian on 7/21/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weather: WeatherViewModel
    
    @State private var cityName = ""
    @State private var animatedGardient: Bool = false
    
    var startColor: Color = Color.blue
    var endColor: Color = Color.yellow
    
    var body: some View {
        ZStack{
            backround
            VStack {
                title.padding()
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
            Text("weathery").font(Font.custom("cute - Personal Use", size: 80)).opacity(0.7)
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
                withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)){
                    animatedGardient.toggle()
            }
        }
    }
    
    func createTaskbarButton(iconName: String, name: String, action: @escaping () -> Void) -> some View {
        return Button {
            action()
        } label: {
            VStack {
                Image(systemName: iconName)
                    .foregroundStyle(.black)
                    .font(.title)
            }
        }
    }

    var taskBar: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 350, height: 60)
                    .opacity(0.4)
                HStack {
                    Spacer()
                    createTaskbarButton(iconName: "house.fill", name: "Home") {
                        
                    }
                    Spacer()
                    createTaskbarButton(iconName: "list.bullet.rectangle.fill", name: "My Cities") {
                        
                    }
                    Spacer()
                    createTaskbarButton(iconName: "paperplane.fill", name: "My Location") {
                        
                    }
                    Spacer()
                }
                .padding(.horizontal, 10)
                .opacity(0.8)
            }
        }
    }



#Preview {
    ContentView(weather: WeatherViewModel())
}
