import SwiftUI

struct ForecastView: View {
    //access modelData environment object
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack{
            //backgroud image and its properties
            Image("background")
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 110)
                .ignoresSafeArea(.container)
            VStack{
                //displays the location of the user
                Text(modelData.addressLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                List{//daily array from forcast and a for loop to check all the days
                    ForEach(modelData.forecast!.daily) { day in
                        DailyView(day: day)
                    }
                }
                .background(Color.clear)
                .opacity(0.8)
            }
        }
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
