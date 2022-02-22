
import Foundation



struct Order: Codable {
    
    var internalId: UUID = UUID()
    var brickLinkId: String
    var orderDate: String
    var totalItems: String
    var shippingBilled: String
    var shippingMyCost: String
}


extension Order: Identifiable {
    
    var id: UUID { internalId }
}
