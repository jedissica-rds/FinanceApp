import SwiftUI

struct ExpenseSummary: View {
    
    @Environment(Model.self) var model
    
    @State var isAddingExpense = false
    
    var body: some View {
        List {
            Section {
                LabeledContent("Total Income", value: model.income.formatted(.dollar()))
                LabeledContent("Total Expenses", value: model.totalExpenses.formatted(.dollar()))
                
                LabeledContent("Balance") {
                    Text(model.balance, format: .dollar())
                        .foregroundStyle(model.balance >= 0 ? .green : .red)
                }
            }
            
            Section("Expenses By Category") {
                ForEach(model.categorySummaries, id: \.category) { summary in
                    ExpenseRow(categorySummary: summary)
                }
            }
            
            Section("Latest Expenses") {
                ForEach(model.latestExpenses) { expense in
                    NavigationLink {
                        ExpenseDetail(expense: expense)
                    } label: {
                        ExpenseRow(expense: expense)
                    }
                }
            }
            
            Section {
                NavigationLink("Show All Expenses") {
                    ExpenseList(expenses: model.expenses)
                }
            }
        }
        .navigationTitle("Summary")
        .sheet(isPresented: $isAddingExpense) {
            ExpenseEditor(mode: .new)
        }
        .toolbar {
            Button("Add", systemImage: "plus") {
                isAddingExpense = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        ExpenseSummary()
            .environment(Model())
    }
}
