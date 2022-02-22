
import Foundation



struct Order_LegacyModel_v1: Decodable {
    
    var internalId: UUID = UUID()
    var brickLinkId: String
    var totalItems: String
}
