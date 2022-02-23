
import SwiftUI



struct StatsDetailView: View {
    
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    var statsPeriod: StatsPeriod
    
    
    var body: some View {
        
          VStack {
            
            let orders = self.appDataStorage.appData.orders.filter { $0.orderDate >= statsPeriod.dateStart && $0.orderDate <= statsPeriod.dateEnd }
            
            let shippingBilledValues = orders.compactMap { Double($0.shippingBilled) }
            let averageShippingBilled = shippingBilledValues.reduce(0.0, +) / Double(shippingBilledValues.count)
            
            Text("Average shipping billed: \(averageShippingBilled)")
            
            let shippingMyCostValues = orders.compactMap { Double($0.shippingMyCost) }
            let averageShippingMyCost = shippingMyCostValues.reduce(0.0, +) / Double(shippingMyCostValues.count)
            
            Text("Average shipping my cost: \(averageShippingMyCost)")
        }
    }
}
