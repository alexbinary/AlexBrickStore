
import SwiftUI



struct OrderView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var order: Order
    
    
    var body: some View {
        
        VStack {
            
            TextField("Order id", text: self.$order.brickLinkId)
            DatePicker("Order date", selection: self.$order.orderDate)
            TextField("Total items", text: self.$order.totalItems)
            TextField("Shipping billed", text: self.$order.shippingBilled)
            TextField("Shipping my cost", text: self.$order.shippingMyCost)
            
            Button(action: {
                
                appDataStorage.saveOrder(order)
                
            }, label: {
                
                Text("Save")
            })
            
            Button(action: {
                
                appDataStorage.deleteOrder(order)
                
            }, label: {
                
                Text("Delete order")
            })
        }
    }
}
