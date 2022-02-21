
import SwiftUI



struct ContentView: View {
    
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    
    var body: some View {
        
        VStack {
        
            Button(action: {
                
                let newOrder = Order(id: "new")
                appDataStorage.addNewOrder(newOrder)
                
            }, label: {
                
                Text("Add order")
            })
            
            let orders = appDataStorage.appData?.orders ?? []
            if orders.isEmpty {
                
                Text("No orders")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else {
            
                ForEach(appDataStorage.appData?.orders ?? []) { order in
                
                    Text(order.id)
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}
