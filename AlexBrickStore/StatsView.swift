
import SwiftUI



struct StatsView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var dateStart: Date = Date()
    @State var dateEnd: Date = Date()
    
    
    var body: some View {
        
        VStack {
            
            DatePicker("Start", selection: self.$dateStart)
            DatePicker("End", selection: self.$dateEnd)
    
            let orders = self.appDataStorage.appData.orders.filter { $0.orderDate >= self.dateStart && $0.orderDate <= self.dateEnd }
            
            let shippingBilledValues = orders.compactMap { Double($0.shippingBilled) }
            let averageShippingBilled = shippingBilledValues.reduce(0.0, +) / Double(shippingBilledValues.count)
            
            Text("Average shipping billed: \(averageShippingBilled)")
            
            let shippingMyCostValues = orders.compactMap { Double($0.shippingMyCost) }
            let averageShippingMyCost = shippingMyCostValues.reduce(0.0, +) / Double(shippingMyCostValues.count)
            
            Text("Average shipping my cost: \(averageShippingMyCost)")
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Close")
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



struct StatsView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        StatsView()
    }
}
