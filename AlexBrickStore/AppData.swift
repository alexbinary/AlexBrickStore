
import Foundation



struct AppData: Codable {

    
    var orders: [Order] = []
}



struct Order: Codable, Identifiable {
    
    let id: String
}
