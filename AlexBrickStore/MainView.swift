
import SwiftUI



struct MainView: View {
    
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var selectedOrderId: UUID? = nil
    
    
    var body: some View {
        
        TabView {
        
            NavigationView {

                VStack {

                    NavigationLink("Add order", destination: OrderView(order: Order(brickLinkId: "", orderDate: Date(), totalItems: "", shippingBilled: "", shippingMyCost: "")))
                    
                    let orders = appDataStorage.appData?.orders ?? []
                    if orders.isEmpty {

                        Text("No orders")

                    } else {

                        List(orders) { order in

                            NavigationLink(
                                destination: OrderView(order: order),
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
                .tabItem {
                    Text("Orders")
                }
            
            StatsView()
                .environmentObject(self.appDataStorage)
                .tabItem {
                    Text("Stats")
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
