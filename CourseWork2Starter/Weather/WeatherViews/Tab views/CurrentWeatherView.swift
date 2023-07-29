import SwiftUI

struct CurrentWeatherView: View {
    //enviroment object which is used to store data across multiple views
    @EnvironmentObject var modelData: ModelData
    
    //state var which is used for the string variable type.
//    @State var locationString: String = "No location"
    
    var body: some View {
        ZStack {
            //background image
            Image("background2").resizable()
                .ignoresSafeArea()
                .opacity(0.45)
            VStack {
                //displays the location of the user
                Text(modelData.addressLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                VStack{
                    VStack(spacing: 10) {
                        //show the current temperatur
                        Text("\((Int)(modelData.forecast!.current.temp))ºC")
                            .padding()
                            .font(.largeTitle)
                        HStack {
                            //async image of weather description
                            AsyncImage(
                                url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png"),
                                content: {
                                    image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth:100, maxHeight: 100 )
                                },
                                placeholder:{
                                    //placeholder while the image loads
                                    ProgressView()
                                }
                            )
                            //weather description
                            Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                                .foregroundColor(.black)
                        }
                        
                        HStack(spacing: 50){
                            //high temperature
                            Text("H:\((Int)(modelData.forecast!.daily[0].temp.max))ºC")
                                .foregroundColor(.black)
                                .font(.title3)
                            //low temperature
                            Text("Low:\((Int)(modelData.forecast!.daily[0].temp.min))ºC")
                                .foregroundColor(.black)
                                .font(.title3)
                        }
                    }.padding()
                    VStack(){
                        HStack{
                            
                            //wind speed
                            Text("Wind Speed: \((Int)(modelData.forecast!.current.windSpeed))m/s")
                                .padding()
                                .font(.title3)
                                .foregroundColor(.black)
                            
                            //wind direction
                            Text("Direction: \(convertDegToCardinal(deg:modelData.forecast!.current.windDeg))")
                                .padding()
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                        
                        HStack{
                            
                            //humidity
                            Text("Humidity: \((Int)(modelData.forecast!.current.humidity))%")
                                .padding()
                                .font(.title3)
                                .foregroundColor(.black)
                            
                            //pressure
                            Text("Pressure: \((Int)(modelData.forecast!.current.pressure)) hPg")
                                .padding()
                                .font(.title3)
                                .foregroundColor(.black)
                        }
                        
                        HStack{
                            //sunrise/sunset
                            Image(systemName: "sunset.fill").renderingMode(.original)
                            Text(Date(timeIntervalSince1970: TimeInterval(((modelData.forecast!.current.sunset ?? 0 ))))
                                .formatted(.dateTime.hour().minute()))
                            .padding()
                            .font(.title3)
                            .foregroundColor(.black)
                            
                            //sunrise/sunder
                            Image(systemName: "sunrise.fill").renderingMode(.original)
                            Text(Date(timeIntervalSince1970: TimeInterval(((modelData.forecast!.current.sunrise ?? 0 ))))
                                .formatted(.dateTime.hour().minute()))
                            .padding()
                            .font(.title3)
                            .foregroundColor(.black)
                                
                        }

                    }
                    
                }
                
            }
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
            
        }.ignoresSafeArea(edges: [.top, .trailing, .leading])
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(ModelData())
    }
}
