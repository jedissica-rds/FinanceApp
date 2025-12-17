import SwiftUI

struct ExpenseDetail: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(Model.self) var model
    
    let expense: Expense
    
    @State private var isEditing = false
    
    var body: some View {
        List {
            Section {
                ExpenseHeader(expense: expense)
            }
            
            Section("Description") {
                Text(expense.description)
            }
            
            Section("Details") {
                LabeledContent("Date", value: expense.date.formatted())
                LabeledContent("Category", value: expense.category.displayText)
            }
        }
        .sheet(isPresented: $isEditing) {
            ExpenseEditor(
                mode: .edit(
                    expense,
                    didDelete: { dismiss() }
                )
            )
            .environment(model)
        }
        .toolbar {
            Button("Edit") {
                isEditing.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ExpenseDetail(
            expense: .init(
                id: "1",
                date: .now,
                description: "A short description",
                amount: 190.90,
                category: .education
            )
        )
    }
    .environment(Model())
}
