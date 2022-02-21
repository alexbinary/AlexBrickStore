
import SwiftUI



struct OrderView: View {
    
    
    @State var order: Order
    
    
    var body: some View {
        
        VStack {
        
            TextField("Order id", text: self.$order.id)
        }
    }
}



struct OrderView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        OrderView(order: Order(id: "test id"))
    }
}
