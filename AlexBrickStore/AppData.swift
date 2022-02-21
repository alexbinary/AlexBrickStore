
import Foundation



struct AppData: Codable {

    
    var orders: [Order] = []
}



struct Order: Codable, Identifiable {
    
    var id: String
}
