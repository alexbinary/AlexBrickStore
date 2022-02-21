
import Foundation



class AppDataStorage: ObservableObject {
    
    
    var appData: AppData? = nil
    
    
    static let baseFilePath = FileManager.default.currentDirectoryPath.appending("/appdata.json")
    
    static let fileUrl: URL = URL(fileURLWithPath: baseFilePath)
    static let backupFileUrl: URL = URL(fileURLWithPath: baseFilePath.replacingOccurrences(of: ".json", with: "-\(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium).replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: ":", with: "-")).json"))
    
    
    func loadAppData() {
        
        self.appData = try? JSONDecoder().decode(AppData.self, from: Data(contentsOf: Self.fileUrl))
        self.persistAppData(to: Self.backupFileUrl)
    }

    
    func persistAppData(to url: URL = AppDataStorage.fileUrl) {
        
        try! JSONEncoder().encode(appData).write(to: url)
        print("Saved app data to \(url)")
    }
}
