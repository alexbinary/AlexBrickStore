
import Foundation



struct StatsPeriod: Codable, Identifiable {
    
    
    var id: UUID = UUID()
    var dateStart: Date
    var dateEnd: Date
}
