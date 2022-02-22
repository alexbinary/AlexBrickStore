
import Foundation



struct Order_LegacyModel_v2: Decodable {
    
    var internalId: UUID = UUID()
    var brickLinkId: String
    var totalItems: String
    var shippingBilled: String
}
