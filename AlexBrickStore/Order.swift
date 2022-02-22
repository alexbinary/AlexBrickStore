
import Foundation



struct Order: Codable {
    
    var internalId: UUID = UUID()
    var brickLinkId: String
    var totalItems: String
    var shippingBilled: String
}


extension Order: Identifiable {
    
    var id: UUID { internalId }
}
