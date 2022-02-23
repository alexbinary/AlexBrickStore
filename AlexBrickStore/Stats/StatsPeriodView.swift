
import SwiftUI



struct StatsPeriodView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var statsPeriod: StatsPeriod = StatsPeriod(dateStart: Date(), dateEnd: Date())
    
    
    var body: some View {
        
        VStack {
            
            DatePicker("Start", selection: self.$statsPeriod.dateStart)
            DatePicker("End", selection: self.$statsPeriod.dateEnd)
            
            Button(action: {
                
                appDataStorage.saveStatsPeriod(self.statsPeriod)
                self.presentationMode.wrappedValue.dismiss()
                
            }, label: {
                
                Text("Save")
            })
        }
    }
}
