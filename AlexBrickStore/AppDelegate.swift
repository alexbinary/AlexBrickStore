
import Cocoa
import SwiftUI



@main
class AppDelegate: NSObject, NSApplicationDelegate {

    
    var window: NSWindow!

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    
        let appDataStorage = AppDataStorage()
        appDataStorage.loadAppData()
        
        let contentView = ContentView()
            .environmentObject(appDataStorage)
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }
}
