import SwiftUI

struct HourlyView: View {
    //access modelData environment object
   @EnvironmentObject var modelData: ModelData

    var body: some View {
        ZStack{
            //background image and its properties
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
                    .multilineTextAlignment(.center)
        
                List {
                    //for loop that checks the hourly forecast
                    ForEach(modelData.forecast!.hourly) { hour in
                        HourCondition(current: hour)
                    }
                }
                .background(Color.clear)
                .opacity(0.8)
            }
        }
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
