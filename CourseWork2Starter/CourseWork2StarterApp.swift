import SwiftUI

@main
struct CourseWork2StarterApp: App {
    
    @StateObject var modelData = ModelData()
    @StateObject var airPollutionViewModel = AirPollutionViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(airPollutionViewModel)
        }
    }
}
