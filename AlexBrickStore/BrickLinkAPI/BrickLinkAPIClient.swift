
import Foundation



struct BrickLinkAPIClient {
    
    
    let credentials: BrickLinkAPICredentials
    
    
    init(with credentials: BrickLinkAPICredentials) {
        
        self.credentials = credentials
    }
    
    
    func getMyOrdersReceived(completion: @escaping ([BrickLinkOrder]) -> Void) {
        
        let url = URL(string: "https://api.bricklink.com/api/store/v1/orders?direction=in")!
        
        var request = URLRequest(url: url)
        
        request.addAuthentication(using: credentials)
        
        return getResponse(for: request) { (response: BrickLinkAPIResponse<[BrickLinkOrder]>) in
            
            let orders = response.data
            
            completion(orders)
        }
    }
    
    
    func getResponse<T>(for request: URLRequest, completion: @escaping (T) -> Void) where T: Decodable {
        
        URLSession(configuration: .default).dataTask (with: request) { (data, response, error) in
                
            print(String(data: data!, encoding: .utf8)!)
            
            let decoded: T = data!.decode()
            
            completion(decoded)
                
        } .resume()
    }
}


extension Data {
    
    
    init<T>(encodingAsJSON value: T) where T: Encodable {
    
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        self = try! encoder.encode(value)
    }
    
    
    func decode<T>() -> T where T: Decodable {
        
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        
        decoder.dateDecodingStrategy = .custom({ (decoder) in
            let stringValue = try! decoder.singleValueContainer().decode(String.self)
            return dateFormatter.date(from: stringValue)!
        })
        
        let decoded = try! decoder.decode(T.self, from: self)
        
        return decoded
    }
}
