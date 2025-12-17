import SwiftUI

struct ExpenseEditor: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(Model.self) var model
    
    private let expense: Expense
    private var didDelete: (() -> Void) = {}
    
    @State var description: String = ""
    @State var amount: Double?
    @State var date: Date = .now
    @State var category: Expense.Category = .miscellaneous
    @State var mode: Mode
    
    init(mode: Mode) {
        self.mode = mode
        
        switch mode {
            case .edit(let expense, let didDelete):
                self.expense = expense
                self.didDelete = didDelete
            case .new:
                self.expense = Expense.new()
        }
    }
    
    var canSave: Bool {
        let hasDescription = !description.isEmpty
        let hasAmount = amount != 0
        return hasDescription && hasAmount
    }
    
    var navigationTitle: String {
        switch mode {
            case .edit: "Edit Expense"
            case .new: "New Expense"
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Amount", value: $amount, format: .dollar())
                    .keyboardType(.decimalPad)
                
                TextField("Description", text: $description)
                
                Section {
                    DatePicker("Date", selection: $date)
                    
                    Picker("Category", selection: $category) {
                        ForEach(Expense.Category.allCases, id: \.self) { expense in
                            Text(expense.displayText)
                                .tag(expense)
                        }
                    }
                }
                
                switch mode {
                    case .edit:
                        Button("Delete", role: .destructive) {
                            onDelete()
                        }
                    case .new:
                        EmptyView()
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save", systemImage: "checkmark") {
                    onSave()
                }
                .disabled(!canSave)
            }
            .onAppear {
                amount = expense.amount == 0 ? nil : expense.amount
                description = expense.description
                date = expense.date
                category = expense.category
            }
        }
    }
    
    func onDelete() {
        model.delete(expense: expense)
        didDelete()
        dismiss()
    }
    
    func onSave() {
        let expense = Expense(
            id: expense.id,
            date: date,
            description: description,
            amount: amount ?? 0,
            category: category
        )
        
        switch mode {
            case .edit:
                model.update(expense: expense)
            case .new:
                model.new(expense: expense)
        }
        
        dismiss()
    }
}

extension ExpenseEditor {
    enum Mode {
        case edit(_ expense: Expense, didDelete: () -> Void)
        case new
    }
}

#Preview("New") {
    ExpenseEditor(mode: .new)
        .environment(Model())
}

#Preview("Edit") {
    ExpenseEditor(
        mode: .edit(
            .init(
                id: "1",
                date: .now,
                description: "A short description",
                amount: 190.90,
                category: .education
            ),
            didDelete: {}
        )
    )
    .environment(Model())
}
