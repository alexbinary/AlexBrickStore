
import SwiftUI



struct ContentView: View {
    
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var sheetPresented = false
    @State var editOrderId = ""
    
    
    var body: some View {
        
        VStack {
        
            Button(action: {
                
                self.sheetPresented = true
                
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
        .sheet(isPresented: self.$sheetPresented) {
            
            TextField("Order id", text: self.$editOrderId)
            
            Button(action: {
                
                let newOrder = Order(id: self.editOrderId)
                appDataStorage.addNewOrder(newOrder)
                
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
        
        ContentView()
    }
}
