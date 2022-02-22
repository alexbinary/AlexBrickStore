
import SwiftUI



struct StatsView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    
    var body: some View {
        
        VStack {
    
            let shippingBilledValues = self.appDataStorage.appData.orders.compactMap { Double($0.shippingBilled) }
            let averageShippingBilled = shippingBilledValues.reduce(0.0, +) / Double(shippingBilledValues.count)
            
            Text("Average shipping billed: \(averageShippingBilled)")
            
            let shippingMyCostValues = self.appDataStorage.appData.orders.compactMap { Double($0.shippingMyCost) }
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
