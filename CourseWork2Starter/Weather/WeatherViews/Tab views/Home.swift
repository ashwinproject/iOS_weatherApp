import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var isSearchOpen: Bool = false
    
    //hold the location the user wants to search
    @State  var userLocation: String = ""
    
    
    var body: some View {
        ZStack{
            //setting the background image along with its properties
            Image("background2")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.45)
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        self.isSearchOpen.toggle()
                    } label: {
                        Text("Change Location")
                            .bold()
                            .font(.system(size: 30))
                    }
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                    }
                    .padding()
                    Spacer()
                    
                }
                Spacer()
                
                //displays the location of the user
                Text(modelData.addressLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                //sets the current date and time
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                    .formatted(.dateTime.year().hour().month().day()))
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 1)
                
                Spacer()
                
                //displays the current temperature
                Text("Temp: \((Int)(modelData.forecast!.current.temp))ºC")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)

                //displays the current humidity
                Text("Humidity: \((Int)(modelData.forecast!.current.humidity))%")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                //displays the current pressure
                Text("Pressure: \((Int)(modelData.forecast!.current.pressure)) hPa")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                HStack{
                    //async image which is loaded from the link below
                    AsyncImage(
                        url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png"),
                        content: {
                            image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth:100, maxHeight: 100 )
                        },
                        placeholder:{
                            ProgressView()
                        }
                    )
                    //describes the image with appropriate description.
                    Text("\(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                }
                
            }
            
            .onAppear {

            }
        }
    }
    
    
    struct Home_Previews : PreviewProvider {
        static var previews: some View {
            Home()
                .environmentObject(ModelData())
        }
    }
    
}
