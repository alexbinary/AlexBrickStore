
import Foundation



class CloudStorageAgent {
    
    
    func start() {
        
        let testDataUrl = Bundle.main.url(forResource: "bricklinktestdata", withExtension: "json")!
        print("Loading test data from \(testDataUrl)")
        
        let testDataRaw = try! Data(contentsOf: testDataUrl)
        let testDataDecoded: BrickLinkAPIResponse<[BrickLinkOrder]> = testDataRaw.decode()
        
        
    }
}
