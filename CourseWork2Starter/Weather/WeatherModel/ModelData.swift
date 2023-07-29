import Foundation

enum APIError: Error {
        case noData
    }

class ModelData: ObservableObject {
    
    @Published var forecast: Forecast? //to hold the forecast data
    @Published var addressLocation: String = "n/a" // empty string to use user location
    
    let APIKEY = "xxxxxxxxxxxxxxx"
    
    init() {
        self.forecast = load("london.json")
        LocationManager().getAddressFromCoordinates(latitude: self.forecast?.lat ?? 0, longitude: self.forecast?.lon ?? 0) { address in
            if let address = address {
                self.addressLocation = address
            } else {
                print("Error:JSON address failed")
            }
        }
    }
    
    //async func runs in the bg, returns forecase
    func loadData(lat: Double, lon: Double, completion: @escaping (Result<Forecast, Error>) -> Void) {
            let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=\(APIKEY)")
            let session = URLSession(configuration: .default)
            
        //creates a data task
            let task = session.dataTask(with: url!) { data, response, error in
                
                //checks to see if there is an error
                if let error = error {
                    completion(.failure(error))
                    return
                }
                //unwraps the data and checks
                guard let data = data else {
                    completion(.failure(APIError.noData))
                    return
                }
                
                //do catch to handle any errors
                do {
                    //decodes the data to forecast type
                    let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
                    DispatchQueue.main.async {
                        self.forecast = forecastData
                    }
                    completion(.success(forecastData))
                } catch {
                    //passes the error as a error case
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    
    //load data from selected files
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

//reference for error handling : https://developer.apple.com/documentation/swift/error
