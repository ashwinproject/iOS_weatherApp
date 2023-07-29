import SwiftUI

struct HourCondition: View {
    var current : Current
    @EnvironmentObject var modelData : ModelData
  
    
    var body: some View {
        HStack {
            VStack {
                //time
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current.dt + modelData.forecast!.timezoneOffset ))))
                    .formatted(.dateTime.hour()))
                .font(.title2)
                //weekday
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current.dt + modelData.forecast!.timezoneOffset ))))
                    .formatted(.dateTime.weekday()))
                .font(.title2)
            }
            Spacer()
            AsyncImage(
                //asunc image
                url: URL(string:  "https://openweathermap.org/img/wn/\(self.current.weather[0].icon)@2x.png"),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 80, maxHeight: 80)
                },
                placeholder: {
                    //a placeholder while the image loads
                    ProgressView()
                }
            )
            Spacer()
            //temperature
            Text("\((Int)(self.current.temp))ºC ")
            
            //description
            Text(self.current.weather[0].weatherDescription.rawValue.capitalized)
                

        }.padding()
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = ModelData().forecast!.hourly
    
    static var previews: some View {
        HourCondition(current: hourly[0])
            .environmentObject(ModelData())
    }
}
