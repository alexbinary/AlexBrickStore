
import SwiftUI



struct OrderView: View {
    
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var order: Order
    
    
    var body: some View {
        
        VStack {
        
            TextField("Order id", text: self.$order.brickLinkId)
            TextField("Total items", text: self.$order.totalItems)
            TextField("Shipping billed", text: self.$order.shippingBilled)
            TextField("Shipping my cost", text: self.$order.shippingMyCost)
            
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
        
        OrderView(order: Order(brickLinkId: "test id", totalItems: "", shippingBilled: "", shippingMyCost: ""))
    }
}
