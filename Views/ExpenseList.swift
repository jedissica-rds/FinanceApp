import SwiftUI

struct ExpenseList: View {
    
    let expenses: [Expense]
    
    var sortedExpenses: [Expense] {
        expenses.sorted(by: { $0.date > $1.date })
    }
    
    var body: some View {
        List {
            ForEach(sortedExpenses) { expense in
                NavigationLink {
                    ExpenseDetail(expense: expense)
                } label: {
                    ExpenseRow(expense: expense)
                }
            }
        }
        .navigationTitle("Expenses")
    }
}

#Preview {
    NavigationStack {
        ExpenseList(expenses: Model().expenses)
    }
}
