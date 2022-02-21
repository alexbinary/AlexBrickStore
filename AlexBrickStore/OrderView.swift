
import SwiftUI



struct OrderView: View {
    
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var order: Order
    
    
    var body: some View {
        
        VStack {
        
            TextField("Order id", text: self.$order.id)
            
            Button(action: {
                
                appDataStorage.saveOrder(order)
                
            }, label: {
                
                Text("Save")
            })
        }
    }
}



struct OrderView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        OrderView(order: Order(id: "test id"))
    }
}
