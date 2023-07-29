import SwiftUI

struct NavBar: View {
    
    var body: some View {
        TabView{
           Home()
                .tabItem{
                    //sets the labels name and icon
                    Label("City", systemImage: "magnifyingglass")
                }
            CurrentWeatherView()
                .tabItem {
                    Label("WeatherNow", systemImage: "sun.max.fill")
                }
            
            HourlyView()
                .tabItem{
                    Label("HourlyView", systemImage: "clock.fill")
                }
            ForecastView()
                .tabItem {
                    Label("ForecastView", systemImage: "calendar")
                }
            PollutionView()
                .tabItem {
                    Label("PollutionView", systemImage: "aqi.high")
                }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
        
}

