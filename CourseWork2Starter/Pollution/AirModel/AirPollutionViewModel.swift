import Foundation

class AirPollutionViewModel: ObservableObject {
    
    @Published var airPollutionData: AirPollution?
    private var forecast: Forecast?
    
    let APIKEY = "79040a34cfa153bfc85cebb33b65413c"
    
    init() {
        self.forecast = load("london.json")
        Task {
            do {
                self.airPollutionData = try await loadData(lat: forecast?.lat ?? 0, lon: forecast?.lon ?? 0)
            } catch {
                return
            }
        }
    }
    
    func loadData(lat: Double, lon: Double) async throws -> AirPollution {
        
        let url = URL(string:
                        "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(APIKEY)")
        let session = URLSession(configuration: .default)

        let (data, _) = try await session.data(from: url!)

        do {
            let airData = try JSONDecoder().decode(AirPollution.self, from: data)
            DispatchQueue.main.async {
                
                self.airPollutionData = airData
            }
            return airData
            
        } catch {
            throw error
        }
        
    }
    
    //load to load from json file
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
    
}



