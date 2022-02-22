
import Foundation



struct Order_PreviousStorageModel: Decodable {
    
    var internalId: UUID = UUID()
    var brickLinkId: String
    var orderDate: Date
    var totalItems: String
    var shippingBilled: String
    var shippingMyCost: String
}
