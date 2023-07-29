import Foundation

struct AirPollution: Codable {
    let coord: Coord
    let list: [AirPollutionList]
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - List
struct AirPollutionList: Codable {
    let main: AirPollutionMain
    let components: [String: Double]
    let dt: Int
}

// MARK: - Main
struct AirPollutionMain: Codable {
    let aqi: Int
}

//webiste used : https://app.quicktype.io/
