
import Foundation
import SQLite3



class StorageAgent {
    
    
    func start() {
        
        let testDataUrl = Bundle.main.url(forResource: "bricklinktestdata", withExtension: "json")!
        print("Loading test data from \(testDataUrl)")
        
        let testDataRaw = try! Data(contentsOf: testDataUrl)
        let testDataDecoded: BrickLinkAPIResponse<[BrickLinkOrder]> = testDataRaw.decode()
        

        let databasePath = FileManager.default.currentDirectoryPath.appending("/app.db")
        let databaseUrl = URL(fileURLWithPath: databasePath)
        
        let backupDatabaseUrl = URL(fileURLWithPath: databasePath.replacingOccurrences(of: ".db", with: "-\(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium).replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: ":", with: "-")).db"))
        try? Data(contentsOf: databaseUrl).write(to: backupDatabaseUrl)
        print("backed up database at \(backupDatabaseUrl)")
        
        var connectionPointer: OpaquePointer!
        
        guard sqlite3_open(databasePath, &connectionPointer) == SQLITE_OK else {
            fatalError("[Connection] sqlite3_open() failed. Opening database: \(databasePath). SQLite error: \(errorMessage(from: connectionPointer) ?? "")")
        }
        print("[Connection] Connected")
        
        defer {
            
            print("[Connection] Closing connection")
            sqlite3_close(connectionPointer)
        }
    }
    
    
    func errorMessage(from pointer: OpaquePointer) -> String? {
            
        if let raw = sqlite3_errmsg(pointer) {
            return String(cString: raw)
        } else {
            return nil
        }
    }
}
