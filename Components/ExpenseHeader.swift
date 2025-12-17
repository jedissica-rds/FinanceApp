import SwiftUI

struct ExpenseHeader: View {
    
    let expense: Expense
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(expense.amount, format: .dollar())
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding(.vertical, 80)
        .foregroundStyle(.white)
        .listRowBackground(expense.category.backgroundColor)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    List {
        ExpenseHeader(
            expense: .init(
                id: "1",
                date: .now,
                description: "A short description",
                amount: 190.90,
                category: .food
            )
        )
    }
}
