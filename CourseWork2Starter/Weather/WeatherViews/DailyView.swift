import SwiftUI

struct DailyView: View {
    //daily structure
    var day : Daily
    
    //environment object to access modelData
    @EnvironmentObject var modelData: ModelData
   
    var body: some View {
        
        HStack(alignment: .center) {
            //async image loaded from the link
            AsyncImage(
                url: URL(string: "https://openweathermap.org/img/wn/\(self.day.weather[0].icon)@2x.png"),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 70, maxHeight: 70)
                    //setting the image properties
                },
                placeholder: {
                    //placeholder while the image loads
                    ProgressView()
                }
            )
            Spacer()
            VStack {
                //weather description text
                Text(self.day.weather[0].weatherDescription.rawValue.capitalized)
                HStack{
                    //set the day of the week with .weekday(.wide)
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(day.dt + modelData.forecast!.timezoneOffset ))))
                        .formatted(.dateTime.weekday(.wide)))
                    
                    //day of the week
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(day.dt + modelData.forecast!.timezoneOffset ))))
                        .formatted(.dateTime.day()))
                }
            }
            Spacer()
            //shows the min and max temperature.
            Text("\((Int)(self.day.temp.max))ºC / \((Int)(self.day.temp.min))ºC")
                
        }.padding()
    }
    
}


struct DailyView_Previews: PreviewProvider {
    static var day = ModelData().forecast!.daily

    static var previews: some View {
        DailyView(day: day[0])
            .environmentObject(ModelData())
    }
}

