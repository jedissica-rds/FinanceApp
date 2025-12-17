import SwiftUI

@main
struct ExpensesApp: App {
    
    @State var model = Model()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ExpenseSummary()
            }
            .environment(model)
        }
    }
}
