import SwiftUI

struct WeatherCardView: View {
    var weather: Weather

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
                        Text(weather.city!)
                            .foregroundStyle(Color.white)
                            .font(Font.custom("SF Pro Rounded", size: 50))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .frame(maxWidth: geometry.size.width)
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
    WeatherCardView(weather: Weather(city: "Bucharest", temperature: 31.5, conditionID: 501))
}
