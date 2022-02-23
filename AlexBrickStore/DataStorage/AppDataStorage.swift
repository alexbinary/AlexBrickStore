
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
        
        let migrateFromPreviousStorageModel = false
        if migrateFromPreviousStorageModel {
            
            let appDataPreviousStorageModel = (try? JSONDecoder().decode(AppData_PreviousStorageModel.self, from: Data(contentsOf: Self.fileUrl))) ?? AppData_PreviousStorageModel()
            self.appData = self.appDataFromPreviousStorageModel(appDataPreviousStorageModel)
            
        } else {
            
            self.appData = (try? JSONDecoder().decode(AppData.self, from: Data(contentsOf: Self.fileUrl))) ?? AppData()
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
    
    
    func deleteOrder(_ order: Order) {
        
        self.appData.orders.removeAll(where: { $0.internalId == order.internalId })
        self.persistAppData()
    }
    
    
    func saveStatsPeriod(_ statsPeriod: StatsPeriod) {
        
        if let idx = self.appData.statsPeriods.firstIndex(where: { $0.id == statsPeriod.id }) {
            self.appData.statsPeriods[idx] = statsPeriod
        } else {
            self.appData.statsPeriods.append(statsPeriod)
        }
        
        self.persistAppData()
    }
    
    
    func deleteStatsPeriod(_ statsPeriod: StatsPeriod) {
        
        self.appData.statsPeriods.removeAll(where: { $0.id == statsPeriod.id })
        self.persistAppData()
    }
    
    
    func appDataFromPreviousStorageModel(_ appDataPreviousStorageModel: AppData_PreviousStorageModel) -> AppData {
        
        var appData = AppData()
        
        appData.orders = appDataPreviousStorageModel.orders.map { orderPreviousStorageModel in
            
            return Order(
                internalId: orderPreviousStorageModel.internalId,
                brickLinkId: orderPreviousStorageModel.brickLinkId,
                orderDate: Date(),
                totalItems: orderPreviousStorageModel.totalItems,
                shippingBilled: orderPreviousStorageModel.shippingBilled,
                shippingMyCost: orderPreviousStorageModel.shippingMyCost
            )
        }
        
        appData.statsPeriods = []
        
        return appData
    }
}
