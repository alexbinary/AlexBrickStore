
import SwiftUI



struct MainView: View {
    
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var sheetPresented = false
    
    @State var editOrderId = ""
    @State var editOrderTotalItems = ""
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
        
                Button(action: {
                    
                    self.sheetPresented = true
                    
                }, label: {
                    
                    Text("Add order")
                })
                
                let orders = appDataStorage.appData?.orders ?? []
                if orders.isEmpty {
                    
                    Text("No orders")
                    
                } else {
                
                    ForEach(appDataStorage.appData?.orders ?? []) { order in
                    
                        NavigationLink(order.id, destination: OrderView(order: order))
                    }
                }
            }
            
            VStack {}
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: self.$sheetPresented) {
            
            TextField("Order id", text: self.$editOrderId)
            TextField("Total items", text: self.$editOrderTotalItems)
            
            Button(action: {
                
                let newOrder = Order(id: self.editOrderId, totalItems: self.editOrderTotalItems)
                appDataStorage.saveOrder(newOrder)
                
                self.sheetPresented = false
                self.editOrderId = ""
                
            }, label: {
                
                Text("Add")
            })
            
            Button(action: {
                
                self.sheetPresented = false
                self.editOrderId = ""
                
            }, label: {
                
                Text("Cancel")
            })
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        MainView()
    }
}
