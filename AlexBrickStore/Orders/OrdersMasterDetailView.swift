
import SwiftUI



struct OrdersMasterDetailView: View {
    
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var selectedOrderId: UUID? = nil
    
    
    var body: some View {
        
        NavigationView {

            VStack {

                Button {
                    
                    let client = BrickLinkAPIClient(with: BrickLinkAPICredentials())
                    client.getMyOrdersReceived { orders in
                        self.appDataStorage.syncOrdersFromBrickLink(orders)
                    }
                    
                } label: {
                    Text("Sync")
                }
                
                NavigationLink("Add order", destination: OrderDetailView(order: Order(brickLinkId: "", orderDate: Date(), totalItems: "", shippingBilled: "", shippingMyCost: "")))
                
                let orders = appDataStorage.appData?.orders ?? []
                if orders.isEmpty {

                    Text("No orders")

                } else {

                    List(orders) { order in

                        NavigationLink(
                            destination: OrderDetailView(order: order),
                            tag: order.internalId,
                            selection: self.$selectedOrderId
                        ) {
                            HStack {
                                Text(order.brickLinkId)
                                Spacer()
                                Button {
                                    self.appDataStorage.deleteOrder(order)
                                    self.selectedOrderId = (appDataStorage.appData?.orders ?? []).first?.internalId
                                } label: {
                                    Text("Delete")
                                }
                            }
                        }
                    }
                        .frame(minHeight: 500)
                }
            }
                .frame(width: 300)

            Text("No order selected")
                .frame(maxWidth: .infinity)
        }
    }
}
