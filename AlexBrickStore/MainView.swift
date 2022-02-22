
import SwiftUI



struct MainView: View {
    
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var sheetPresented = false
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
        
                Button(action: {
                    self.sheetPresented = true
                }, label: {
                    Text("Stats")
                })
                
                NavigationLink("Add order", destination: OrderView(order: Order(brickLinkId: "", orderDate: Date(), totalItems: "", shippingBilled: "", shippingMyCost: "")))
                
                let orders = appDataStorage.appData?.orders ?? []
                if orders.isEmpty {
                    
                    Text("No orders")
                    
                } else {
                
                    ForEach(appDataStorage.appData?.orders ?? []) { order in
                    
                        NavigationLink(order.brickLinkId, destination: OrderView(order: order))
                    }
                }
            }
            
            VStack {}
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: self.$sheetPresented) {
            StatsView()
                .environmentObject(self.appDataStorage)
        }
    }
}



struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        MainView()
    }
}
