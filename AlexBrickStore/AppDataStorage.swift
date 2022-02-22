
import Foundation



class AppDataStorage: ObservableObject {
    
    
    @Published var appData: AppData! = nil
    
    
    static let baseFilePath = FileManager.default.currentDirectoryPath.appending("/appdata.json")
    
    static let fileUrl: URL = URL(fileURLWithPath: baseFilePath)
    static let backupFileUrl: URL = URL(fileURLWithPath: baseFilePath.replacingOccurrences(of: ".json", with: "-\(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium).replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: ":", with: "-")).json"))
    
    
    func backupExistingAppDataOnDisk() {
        
        try? Data(contentsOf: Self.fileUrl).write(to: Self.backupFileUrl)
    }
    
    
    func loadAppData() {
        
        if let appDataVersionOnly = try? JSONDecoder().decode(AppData_VersionOnly.self, from: Data(contentsOf: Self.fileUrl)) {
            
            let storageVersion = appDataVersionOnly.version
            if storageVersion == 1 {
                
                let appData_v1 = (try? JSONDecoder().decode(AppData_LegacyModel_v1.self, from: Data(contentsOf: Self.fileUrl))) ?? AppData_LegacyModel_v1()
                self.appData = self.appDataFromStorageModelLegacyV1(appData_v1)
                
            } else if storageVersion == 2 {
                
                let appData_v2 = (try? JSONDecoder().decode(AppData_LegacyModel_v2.self, from: Data(contentsOf: Self.fileUrl))) ?? AppData_LegacyModel_v2()
                self.appData = self.appDataFromStorageModelLegacyV2(appData_v2)
                
            } else if storageVersion == 3 {
                
                self.appData = (try? JSONDecoder().decode(AppData.self, from: Data(contentsOf: Self.fileUrl))) ?? AppData()
            }
            
        } else {
            
            self.appData = AppData()
        }
        
        self.persistAppData()
    }

    
    func persistAppData() {
        
        self.backupExistingAppDataOnDisk()
        try! JSONEncoder().encode(appData).write(to: Self.fileUrl)
    }
    
    
    func saveOrder(_ order: Order) {
        
        if let idx = self.appData.orders.firstIndex(where: { $0.internalId == order.internalId }) {
            self.appData.orders[idx] = order
        } else {
            self.appData.orders.append(order)
        }
        
        self.persistAppData()
    }
    
    
    func appDataFromStorageModelLegacyV1(_ appDataLegacyModelV1: AppData_LegacyModel_v1) -> AppData {
        
        var appData = AppData()
        
        appData.orders = appDataLegacyModelV1.orders.map { orderLegacyModelV1 in
            
            return Order(
                internalId: orderLegacyModelV1.internalId,
                brickLinkId: orderLegacyModelV1.brickLinkId,
                totalItems: orderLegacyModelV1.totalItems,
                shippingBilled: "",
                shippingMyCost: ""
            )
        }
        
        return appData
    }
    
    
    func appDataFromStorageModelLegacyV2(_ appDataLegacyModelV2: AppData_LegacyModel_v2) -> AppData {
        
        var appData = AppData()
        
        appData.orders = appDataLegacyModelV2.orders.map { orderLegacyModelV2 in
            
            return Order(
                internalId: orderLegacyModelV2.internalId,
                brickLinkId: orderLegacyModelV2.brickLinkId,
                totalItems: orderLegacyModelV2.totalItems,
                shippingBilled: orderLegacyModelV2.shippingBilled,
                shippingMyCost: ""
            )
        }
        
        return appData
    }
}
