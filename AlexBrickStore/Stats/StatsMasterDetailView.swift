
import SwiftUI



struct StatsMasterDetailView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var appDataStorage: AppDataStorage
    
    @State var dateStart: Date = Date()
    @State var dateEnd: Date = Date()
    
    @State var sheetPresented = false
    @State var selectedStatsPeriodForEdit: StatsPeriod = StatsPeriod(dateStart: Date(), dateEnd: Date())
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Button {
                    self.selectedStatsPeriodForEdit = StatsPeriod(dateStart: Date(), dateEnd: Date())
                    self.sheetPresented = true
                } label: {
                    Text("Add Period")
                }
                
                let statsPeriods = self.appDataStorage.appData.statsPeriods
                if statsPeriods.isEmpty {
                    
                    Text("No periods")
                    
                } else {
                    
                    List(statsPeriods) { statsPeriod in
                        
                        NavigationLink(
                            
                            destination: StatsDetailView(statsPeriod: statsPeriod),
                            
                            label: {
                                
                                HStack {
                                    
                                    VStack {
                            
                                        Text("Start: \(statsPeriod.dateStart)")
                                        Text("End: \(statsPeriod.dateEnd)")
                                    }
                                
                                    Spacer()
                                    
                                    Button {
                                        self.selectedStatsPeriodForEdit = statsPeriod
                                        self.sheetPresented = true
                                    } label: {
                                        Text("Edit")
                                    }
                                    Button {
                                        self.appDataStorage.deleteStatsPeriod(statsPeriod)
                                    } label: {
                                        Text("Delete")
                                    }
                                }
                            }
                        )
                    }
                        .frame(minHeight: 500)
                }
            }
            
            Text("No stats selected")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: self.$sheetPresented) {
            StatsPeriodView(statsPeriod: self.selectedStatsPeriodForEdit)
                .environmentObject(self.appDataStorage)
        }
    }
}
