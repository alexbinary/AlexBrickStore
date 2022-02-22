
import SwiftUI



struct MainView: View {
    
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
        
                NavigationLink("Add order", destination: OrderView(order: Order(brickLinkId: "", totalItems: "", shippingBilled: "")))
                
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
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        MainView()
    }
}
