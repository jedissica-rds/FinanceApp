import Foundation

@Observable
class Model {
    
    // Data
    let income: Double = 7500.0
    var expenses: [Expense] = []
    
    init() {
        loadMockData()
    }
}

// MARK: - Computed Properties
extension Model {
    var latestExpenses: [Expense] {
        Array(expenses.sorted(by: { $0.date > $1.date }).prefix(5))
    }
    
    var totalExpenses: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    var balance: Double {
        income - totalExpenses
    }
    
    var categorySummaries: [CategorySummary] {
        let groupedCategories = Dictionary(grouping: expenses, by: { $0.category })
        let summaries = groupedCategories.toCategorySummaries()
        return summaries.sorted(by: { $0.amount > $1.amount })
    }
}

// MARK: - Actions
extension Model {
    func new(expense: Expense) {
        expenses.append(expense)
    }
    
    func update(expense: Expense) {
        guard let index = expenses.firstIndex(where: { $0.id == expense.id }) else { return }
        expenses[index] = expense
    }
    
    func delete(expense: Expense) {
        expenses.removeAll(where: { $0.id == expense.id })
    }
}

// MARK: - Private
private extension Model {
    func loadMockData() {
        guard
            expenses.isEmpty,
            let mockFileUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        else { return }
        
        do {
            let data = try Data(contentsOf: mockFileUrl)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let loadedExpenses = try decoder.decode([Expense].self, from: data)
            expenses = loadedExpenses
        } catch {
            dump(error)
        }
    }
}
