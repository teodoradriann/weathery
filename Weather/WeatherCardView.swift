import SwiftUI

struct WeatherCardView: View {
    let weather: Weather

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 40)
                .frame(width: 350, height: 200)
                .opacity(0.1)
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Image(systemName: weather.conditionName)
                            .font(Font.custom("", size: 80))
                            .foregroundStyle(weather.conditionColor)
                            .frame(width: 80, height: 80)
                            .padding(3)
                        VStack{
                            Text(weather.city ?? "UNKNOWN")
                                .foregroundStyle(Color.white)
                                .font(Font.custom("SF Pro Rounded", size: 50))
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .frame(maxWidth: geometry.size.width)
                            Text(weather.description ?? "UNKNOWN")
                                .font(Font.custom("SF Pro Rounded", size: 20))
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                    }
                    Spacer()
                    HStack() {
                        Text(weather.temperatureString + "°C")
                            .font(Font.custom("SF Pro Rounded", size: 60))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: geometry.size.width)
                    }
                    
                }
                .padding(20)
            }
            .frame(width: 350, height: 200)
        }
    }
}

#Preview {
    WeatherCardView(weather: Weather(city: "Bucharest", temperature: 31.5, conditionID: 800, description: "Sunny"))
}
