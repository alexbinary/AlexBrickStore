
import SwiftUI



struct MainView: View {
    
    
    var body: some View {
        
        TabView {
        
            OrdersMasterDetailView()
                .tabItem {
                    Text("Orders")
                }
            
            StatsMasterDetailView()
                .tabItem {
                    Text("Stats")
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
