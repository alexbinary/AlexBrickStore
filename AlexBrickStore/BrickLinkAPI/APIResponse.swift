
import Foundation



struct BrickLinkAPIResponse<T>: Decodable where T: Decodable {
    
    let data: T
}
