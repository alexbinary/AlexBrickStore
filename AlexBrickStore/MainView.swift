
import SwiftUI



struct MainView: View {
    
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var selectedOrderId: UUID? = nil
    @State var sheetPresented = false
    
    
    var body: some View {
        
        NavigationView {

            VStack {

                Button(action: {
                    self.sheetPresented = true
                }, label: {
                    Text("Stats")
                })

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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: self.$sheetPresented) {
            StatsView()
                .environmentObject(self.appDataStorage)
        }
    }
}
