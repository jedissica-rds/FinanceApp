import SwiftUI

struct ExpenseRow: View {
    
    let title: String
    let subtitle: String
    let category: Expense.Category
    let amount: Double
    
    var body: some View {
        HStack(spacing: 16) {
            ExpenseCategoryIcon(category: category)
            
            VStack(alignment: .leading) {
                Text(title)
                    .lineLimit(1)
                
                Text(subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            
            Spacer(minLength: 0)
            
            Text(amount, format: .dollar())
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

extension ExpenseRow {
    init(expense: Expense) {
        title = expense.description
        subtitle = expense.date.formatted(date: .abbreviated, time: .omitted)
        category = expense.category
        amount = expense.amount
    }
    
    init(categorySummary: CategorySummary) {
        title = categorySummary.category.displayText
        subtitle = "\(categorySummary.expensesCount) expenses"
        category = categorySummary.category
        amount = categorySummary.amount
    }
}

#Preview {
    List {
        Section {
            ExpenseRow(
                expense: .init(
                    id: "1",
                    date: .now,
                    description: "A short description",
                    amount: 19.90,
                    category: .education
                )
            )
            
            ExpenseRow(
                expense: .init(
                    id: "1",
                    date: .now,
                    description: "A short description",
                    amount: 19.90,
                    category: .food
                )
            )
        }
        
        Section {
            ExpenseRow(
                categorySummary: .init(
                    category: .transportation,
                    expensesCount: 5,
                    amount: 5400
                )
            )
        }
    }
}
