import Foundation
import CoreLocation


//cl location manager delage protocol / inherits from NSOObject
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    var currentPlacemark: CLPlacemark?

    override init() {
        super.init()
        locationManager.delegate = self
        //sets the deligate of locationManager to object of self, this will handle location manager events
    }
    
    //method takes two double parameters
    func getAddressFromCoordinates(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()//cl location object using the "latitude" and "logitude" parameters and CLGeocoder
        
        //reverseGeocodeLocation to method-
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard let placemark = placemarks?.first else {
                completion(nil)//if no address is found
                return
            }
            
            //sets value to nw placemark
            self.currentPlacemark = placemark
            
            //array of string
            var addressComponents: [String] = []

            if let street = placemark.thoroughfare {
                addressComponents.append(street)
            }

            if let city = placemark.locality {
                addressComponents.append(city)
            }

            if let country = placemark.country {
                addressComponents.append(country)
            }

            let addressString = addressComponents.joined(separator: ", ")
            completion(addressString)
        }
    }
}

// REFERENCE:

/*Core Locaiton: Generate an Address Format from Reverse Geocoding https://stackoverflow.com/questions/41358423/swift-generate-an-address-format-from-reverse-geocoding
 https://medium.com/aeturnuminc/geocoding-in-swift-611bda45efe1*/
