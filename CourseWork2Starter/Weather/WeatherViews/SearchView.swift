import SwiftUI
import CoreLocation

struct SearchView: View {
    //access the air pollutio  and weather model data environmentObject
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var airVM : AirPollutionViewModel
    
    @Binding var isSearchOpen: Bool
    
    //to hold the user input
    @State var location = ""
    
    @Binding var userLocation: String
    
    //manages the error alert
    @State private var showErrorAlert = false
    @State private var errorAlertMessage = ""
    
    var body: some View {
        Spacer()
        ZStack {
            Color.teal
                .ignoresSafeArea()
            
            VStack{
                //get the users input
                TextField("Enter New Location", text: self.$location, onCommit: {
                    
                    //calls tge geoCodeAddressString method of geocoder
                    CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
                        //checks the placemarks array if it does extrace the lat and long by finding similar match to user input
                        if let lat = placemarks?.first?.location?.coordinate.latitude,
                           let lon = placemarks?.first?.location?.coordinate.longitude {
                            Task {
                                do {
                                    //await to make async calls/ updates the modelData.forecast using loadData
                                    modelData.loadData(lat: lat, lon: lon) { result in
                                        DispatchQueue.main.async {
                                            switch result {
                                            case .success(let forecast):
                                                modelData.forecast = forecast
                                                //when its success
                                            case .failure(_):
                                                // if there is an error
                                                break
                                            }
                                        }
                                    }
                                    //retrieve the address
                                    LocationManager().getAddressFromCoordinates(latitude: lat, longitude: lon, completion: { address in
                                        if let address = address {
                                            modelData.addressLocation = address
                                        } else {
                                            print("Unable to retrieve address string")
                                        }
                                    })
                                    
                                     airVM.airPollutionData = try await airVM.loadData(lat: lat, lon: lon)
                                    
                                } catch {
                                    errorAlertMessage = error.localizedDescription
                                    showErrorAlert = true
                                }
                            }
                            
                            isSearchOpen.toggle()
                        } else {
                            errorAlertMessage = "Location not found"
                            showErrorAlert = true
                        }
                    }
                }
                          
                )
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Ariel", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15) // TextField
                .autocorrectionDisabled()
                .keyboardType(.default)
                
            }
            
        }
        //when alert is true
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorAlertMessage), dismissButton: .default(Text("OK")) {
                showErrorAlert = false
            })
        }
        Spacer()
    }
    
}

/*Alert box reference:
 https://developer.apple.com/documentation/swiftui/alert*/
