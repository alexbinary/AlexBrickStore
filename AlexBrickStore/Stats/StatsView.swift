
import SwiftUI



struct StatsView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var dateStart: Date = Date()
    @State var dateEnd: Date = Date()
    
    @State var sheetPresented = false
    @State var selectedStatsPeriodForEdit: StatsPeriod = StatsPeriod(dateStart: Date(), dateEnd: Date())
    
    
    var body: some View {
        
        VStack {
            
            Button {
                self.selectedStatsPeriodForEdit = StatsPeriod(dateStart: Date(), dateEnd: Date())
                self.sheetPresented = true
            } label: {
                Text("Add Period")
            }
            
            let statsPeriods = self.appDataStorage.appData.statsPeriods
            if statsPeriods.isEmpty {
                
                Text("No periods")
                
            } else {
                
                ForEach(statsPeriods) { statsPeriod in
                    
                    VStack {
                        
                        Text("Start: \(statsPeriod.dateStart)")
                        Text("End: \(statsPeriod.dateEnd)")
                        
                        Button {
                            self.selectedStatsPeriodForEdit = statsPeriod
                            self.sheetPresented = true
                        } label: {
                            Text("Edit")
                        }
                        Button {
                            self.appDataStorage.deleteStatsPeriod(statsPeriod)
                        } label: {
                            Text("Delete")
                        }

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
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Close")
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: self.$sheetPresented) {
            StatsPeriodView(statsPeriod: self.selectedStatsPeriodForEdit)
                .environmentObject(self.appDataStorage)
        }
    }
}
