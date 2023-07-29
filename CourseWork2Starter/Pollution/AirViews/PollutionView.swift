import SwiftUI

struct PollutionView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @EnvironmentObject var airVM: AirPollutionViewModel
    
    var body: some View {
        
        ZStack {
            //sets the backgroung and its properties
            Image("background")
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 110)
                .ignoresSafeArea(.container)
                .opacity(0.7)
            
            VStack {
                //displays the location of the user
                Text(modelData.addressLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                HStack{
                    //loads the weather image
                    AsyncImage(
                        //retrieves the icon information from model data
                        url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png"),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 80, maxHeight: 80)
                        },
                        placeholder: {
                            //place holder while the image loads
                            ProgressView()
                        }
                    )
                    //weather description
                    Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                        .font(.title)
                    
                }
                //high and low temp
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
                //feels like
                Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                    .foregroundColor(.black)
                    .font(.title3)
                    .padding()
                

                Text("Air Quality Data:")
                    .font(.largeTitle)
                
                
                HStack(spacing: 20) {
                    //so2 details
                    VStack(spacing: 30){
                        Image("so2")
                            .frame(width: 50, height: 50)
                            .padding()
                        Text("\(airVM.airPollutionData?.list[0].components["so2"] ?? 0, specifier: "%.2f")")
                    }
                    
                    VStack(spacing: 30){
                        Image("no")
                            .frame(width: 50, height: 50)
                            .padding()
                        Text("\(airVM.airPollutionData?.list[0].components["no"] ?? 0, specifier: "%.2f")")
                    }
                    
                    //voc details
                    VStack(spacing: 30){
                        Image("voc")
                            .frame(width: 50, height: 50)
                            .padding()
                        Text("\(airVM.airPollutionData?.list[0].components["co"] ?? 0, specifier: "%.2f")")
                        
                    }
                    
                    //pm details
                    VStack(spacing: 30){
                        Image("pm")
                            .frame(width: 50, height: 50)
                            .padding()
                        Text("\(airVM.airPollutionData?.list[0].components["pm2_5"] ?? 0, specifier: "%.2f")")
                    }
                }
                .foregroundColor(.black)
                .shadow(color: .black,  radius: 0.5)
                
            }.ignoresSafeArea(edges: [.top, .trailing, .leading])
        }
    }
}
